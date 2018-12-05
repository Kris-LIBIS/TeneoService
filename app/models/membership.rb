# frozen_string_literal: true

class Membership < ApplicationRecord

  self.primary_keys = :user_id, :organization_id, :role_id

  belongs_to :user
  belongs_to :organization
  belongs_to :role

  def self.from_hash(hash)
    super(hash, []) do |item, h|
      user_name = h.delete(:user)
      _user = User.find_by(username: user_name)
      puts "Could not find user '#{user_name}'" unless _user
      item.user = _user

      organization_name = h.delete(:organization)
      _organization = Organization.find_by(name: organization_name)
      puts "Could not find organization '#{organization_name}'" unless _organization
      item.organization = _organization

      role_code = h.delete(:role)
      _role = Role.find_by(code: role_code)
      puts "Could not find role '#{role_code}'" unless _role
      item.role = _role
    end
  end

end
