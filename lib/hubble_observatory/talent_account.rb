module HubbleObservatory
  # Provides methods to interact with the Hubble API talent-accounts endpoint
  # @see https://hubble.fullscreen.net/api/docs#talentaccounts-create-talent-account
  class TalentAccount
    extend Forwardable

    def_delegators self, :do_request, :fetch_hubble_uuid

    def initialize(id:)
      @hubble_uuid = id
    end

    # @return [String] the hubble uuid associated with the email
    def self.create(email:)
      fetch_hubble_uuid do
        do_request(email: email, request_type: :post, route: "talent-accounts")
      end
    end

    # @return [String] the hubble uuid associated with the email
    def update(email:)
      fetch_hubble_uuid do
        do_request(email: email, request_type: :patch,
                   route: "talent-accounts/hubble-uuid/#{@hubble_uuid}")
      end
    end

    private

    def self.do_request(email: nil, request_type: nil, route: nil)
      HubbleObservatory::Request.new(attrs: {body_attrs: {email: email},
                                              request_type: request_type,
                                              route: route,
                                              auth_header: true}).run_request
    end

    def self.fetch_hubble_uuid(&request_block)
      account_data = yield if request_block
      hubble_uuid = if account_data
      extract_hubble_uuid_from_data(data: account_data) ||
        extract_hubble_uuid_from_errors(data: account_data)
      end
      hubble_uuid.to_s if !hubble_uuid.nil?
    end

    def self.extract_hubble_uuid_from_data(data:)
      data.fetch(:data, {}).fetch(:attributes, {}).fetch(:hubble_uuid, nil)
    end

    def self.extract_hubble_uuid_from_errors(data:)
      data.fetch(:errors, [{}])[0].fetch(:hubble_uuid, nil)
    end
  end
end
