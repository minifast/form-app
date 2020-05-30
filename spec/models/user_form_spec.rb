require 'rails_helper'

RSpec.describe UserForm, type: :model do
  it { is_expected.to have_many(:user_form_messages).inverse_of(:user_form).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name).with_message('is too short (minimum is 2 characters)') }

  let(:user_form) { FactoryBot.create(:user_form) }

  it 'Creates a user form' do
    expect(user_form).to be_valid
  end
end
