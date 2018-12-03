# frozen_string_literal: true

class Membership < ApplicationRecord

  self.primary_keys = :user_id, :group_id, :role_id

  belongs_to :user
  belongs_to :group
  belongs_to :role

  def self.from_hash(hash)
    super(hash, []) do |item, h|
      user_name = h.delete(:user)
      _user = User.find_by(username: user_name)
      puts "Could not find user '#{user_name}'" unless _user
      item.user = _user

      group_name = h.delete(:group)
      _group = Group.find_by(name: group_name)
      puts "Could not find group '#{group_name}'" unless _group
      item.group = _group

      role_code = h.delete(:role)
      _role = Role.find_by(code: role_code)
      puts "Could not find role '#{role_code}'" unless _role
      item.role = _role
    end
  end

end
