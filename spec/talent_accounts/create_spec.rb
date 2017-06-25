require 'spec_helper'

describe 'HubbleObservatory::TalentAccount.create' do
  let(:id) { HubbleObservatory::TalentAccount.create email: email }

  context 'with a valid email' do
    let(:email) { "user-#{Time.now.to_i}@example.com" }
    it 'returns the account ID' do
      expect(id).to be_a(Integer)
    end
  end

  context 'with an invalid email' do
    let(:email) { 'not-a-valid-email' }
    it 'returns nil' do
      expect(id).to be_nil
    end
  end

  context 'in case of network error' do
    let(:email) { 'user@example.com' }
    HubbleObservatory::ConnectionError.errors.each do |error_class|
      it "#{error_class} raises a connection error" do
        expect(Net::HTTP).to(receive(:start).and_raise error_class.new)
        expect{id}.to raise_error HubbleObservatory::ConnectionError
      end
    end
  end
end
