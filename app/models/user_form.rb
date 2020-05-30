class UserForm < ApplicationRecord
  has_many :user_form_messages, inverse_of: :user_form, dependent: :destroy
  validates :name, length: { minimum: 2, maximum: 60 }
end
