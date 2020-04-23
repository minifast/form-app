require 'rails_helper'

RSpec.describe UserForm, type: :model do
  it { is_expected.to validate_presence_of(:name).with_message('is too short (minimum is 2 characters)') }
end
