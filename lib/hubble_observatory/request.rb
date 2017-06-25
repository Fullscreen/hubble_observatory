module HubbleObservatory
  # A wrapper around +Net::HTTP+ to send HTTP requests to the Hubble API and
  # return their result or raise an error if the result is unexpected.
  # The basic way to use Request is by calling +run_request+ on an instance.
  class Request
    # Initializes a Request object.
    # @param [Hash] attrs are the options for the request.
    # @option attrs [Symbol] :method (:get) The HTTP method to use.
    # @option attrs [String] :route The (base) route of the API endpoint
    # @option attrs [Hash] :body_attrs ({}) The attributes for the body
    # per the JSON API spec
    def initialize(attrs: {})
      @request_type = attrs.fetch :request_type, :get
      @route = attrs.fetch :route, "talent-accounts"
      @query_params = attrs.fetch :query_params, {}
      @body_attrs = attrs.fetch :body_attrs, nil
      @request_format = attrs.fetch :request_format, :json
      @auth_header = attrs.fetch :auth_header, false
    end

    # Sends the request and returns the response
    def run_request
      if expected_response?
        parse(response)
      end
    end

    # parse the JSON response body
    def parse(response)
      JSON.parse response.body, symbolize_names: true
    end

    private

    def serialize_attributes(attributes:)
      {
        data: {
          type: @route,
          attributes: attributes
        }
      }
    end

    def uri
      @uri ||= URI::HTTPS.build host: host, path: "/api/v1/#{@route}", query: URI.encode_www_form(@query_params)
    end

    def expected_response?
      (response.is_a? Net::HTTPSuccess) || (response.is_a? Net::HTTPUnprocessableEntity)
    end

    def response
      @response ||= Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
        http.request create_http_request
      end
    rescue *ConnectionError.errors => e
      raise ConnectionError, e.message
    end

    def create_http_request
      net_http_class = Object.const_get("Net::HTTP::#{@request_type.capitalize}")
      @http_request ||= net_http_class.new(uri.request_uri).tap do |request|
        assign_request_body request
        assign_request_headers request
      end
    end

    def assign_request_body(request)
      if @body_attrs
        request.body = serialize_attributes(attributes: @body_attrs).to_json
      end
    end

    def assign_request_headers(request)
      http_headers = default_headers
      if @auth_header
        http_headers.merge!(authorization_header)
      end
      http_headers.each_key do |header|
        request[header] = http_headers[header]
      end
      request
    end

    def default_headers
      {"Content-Type" => "application/vnd.api+json"}
    end

    def authorization_header
      {"Authorization" => "Bearer #{ENV['HUBBLE_APP_TOKEN']}"}
    end

    def host
      subdomain = ENV['HUBBLE_ENV'] == 'production' ? 'hubble' : 'rc-hubble'
      "#{subdomain}.fullscreen.net"
    end
  end
end
