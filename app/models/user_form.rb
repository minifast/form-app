class UserForm < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 60 }
end
