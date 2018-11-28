class Membership < ApplicationRecord
  self.primary_keys = :user_id, :group_id, :role_id
  belongs_to :user
  belongs_to :group
  belongs_to :role
end
