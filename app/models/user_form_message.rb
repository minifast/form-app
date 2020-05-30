class UserFormMessage < ApplicationRecord
  belongs_to :user_form, inverse_of: :user_form_messages
  validates :name, :email, :message, presence: true
end
