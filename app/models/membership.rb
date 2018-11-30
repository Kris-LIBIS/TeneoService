class Membership < ApplicationRecord

  self.primary_keys = :user_id, :group_id, :role_id

  belongs_to :user
  belongs_to :group
  belongs_to :role

  def self.from_hash(hash)
    super(hash, []) do |item, h|
      user_name = h.delete(:user)
      group_name = h.delete(:group)
      role_code = h.delete(:role)
      item.user = User.find_by(username: user_name)
      item.group = Group.find_by(name: group_name)
      item.role = Role.find_by(code: role_code)
    end
  end

end
