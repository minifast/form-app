class UserForm < ApplicationRecord
  validates :name, presence: true
end
