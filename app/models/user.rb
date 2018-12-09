# frozen_string_literal: true

class User < ApplicationRecord

  # authentication
  has_secure_password

  # password validation
  validates_length_of :password, minimum: 6, allow_nil: false, allow_blank: false
  # validates_confirmation_of             :password, allow_nil: false, allow_blank: false

  # sanitize email and username
  before_validation do
    self.email = self.email.to_s.downcase
    self.username = self.username.to_s.downcase
  end

  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  has_many :memberships, dependent: :destroy
  has_many :roles, through: :memberships
  has_many :organizations, through: :memberships

  # @param [Organization] organization
  def roles_for(organization)
    organization_list = organization.ancestors
    member_organizations.select {|g, _| organization_list.include?(g)}.map {|_, r| r}.flatten.unique
  end

  def is_authorized?(role, organization)
    self.roles_for(organization).include?(role)
  end

  def add_role(role, organization)
    self.memberships.build(organization: organization, role: role)
  end

  def del_role(role, organization)
    m = self.memberships.find_by(organization: organization, role: role)
    m&.destroy!
  end

  def self.from_token_request(request)
    return nil unless (r = request.params['auth'])
    self.find_by(username: r['username']) || self.find_by(email: r['email'])
  end

  def self.from_token_payload(payload)
    user_id = payload['user_id']
    self.find(user_id)
  end

  def to_token_payload
    {user_id: id}
  end

  # @return [{Organization, [Role]}]
  def member_organizations
    self.memberships.reduce({}) {|h, m| h[m.organization] = ((h[m.organization] ||= []) << m.role)}
  end

  # @param [Hash] hash
  def self.from_hash(hash)
    super(hash, [:username, :email]) do |item, h|
      if (roles = h.delete(:roles))
        roles.each do |role|
          role_code = role[:role]
          r = Role.find_by(code: role_code)
          puts "Could not find role '#{role_code}'" unless r
          organization_name = role[:organization]
          g = Organization.find_by(name: organization_name)
          puts "Could not find organization '#{organization_name}'" unless g
          item.add_role(r, g)
        end
      end
    end
  end

end
