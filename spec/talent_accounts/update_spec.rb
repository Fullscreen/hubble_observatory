require 'spec_helper'

describe 'HubbleObservatory::TalentAccount#update' do
  before(:all) do
    email_to_update = 'updateme@example.com'
    id_to_update = HubbleObservatory::TalentAccount.create email: email_to_update
    @account = HubbleObservatory::TalentAccount.new id: id_to_update

    @existing_email = 'existing@example.com'
    HubbleObservatory::TalentAccount.create email: @existing_email
  end

  let(:id) { @account.update email: email }

  context 'with an email already assigned to another account' do
    let(:email) { @existing_email }
    it 'returns nil' do
      expect(id).to be_nil
    end
  end

  context 'with an original email' do
    let(:email) { "user-#{Time.now.to_i}@example.com" }
    it 'returns the account ID' do
      expect(id).to be_a(Integer)
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
