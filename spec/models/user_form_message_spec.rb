require 'rails_helper'

RSpec.describe UserFormMessage, type: :model do
  it { is_expected.to belong_to(:user_form).inverse_of(:user_form_messages) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:message) }

  let(:user_form_message) { FactoryBot.create(:user_form_message) }

  it 'Creates a user form message' do
    expect(user_form_message).to be_valid
  end
end
