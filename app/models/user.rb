# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable, :rememberable, :registerable
  devise :database_authenticatable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  # authentication
  # has_secure_password

  # password validation
  # validates_length_of :password, minimum: 6, allow_nil: false, allow_blank: false
  # validates_confirmation_of :password, allow_nil: false, allow_blank: false

  # sanitize email and username
  before_validation do
    self.email = self.email.to_s.downcase
  end

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  has_many :memberships, dependent: :destroy
  has_many :roles, through: :memberships
  has_many :organizations, through: :memberships

  accepts_nested_attributes_for :memberships, allow_destroy: true

  def full_name
    r = [first_name, last_name].join(' ')
    r = r.strip
    r.blank? ? email : r
  end

  # def on_jwt_dispatch(_token, payload)
  #   puts "JWT paylod: #{payload}"
  # end

  # def jwt_payload
  #   {
  #       user: {
  #           id: self.id,
  #           first_name: self.first_name,
  #           last_name: self.last_name
  #       }
  #   }
  # end

  # @param [Organization] organization
  # @return [Array<Role>]
  def roles_for(organization)
    self.memberships.where(organization: organization).map(&:role) rescue []
  end

  # @param [Role] role
  # @return [Array<Organization>]
  def organizations_for(role)
    self.memberships.where(role: role).map(&:organization) rescue []
  end

  # @param [Role] role
  # @param [Organization] organization
  # @return [boolean]
  def is_authorized?(role, organization)
    role = Role.find_by(code: role) if role.is_a?(String)
    return false unless role
    self.roles_for(organization).include?(role)
  end

  # @param [Role] role
  # @param [Organization] organization
  # @return [Membership]
  def add_role(role, organization)
    self.memberships.build(organization: organization, role: role)
  end

  # @param [Role] role
  # @param [Organization] organization
  def del_role(role, organization)
    m = self.memberships.find_by(organization: organization, role: role)
    m&.destroy!
  end

  # @return [Hash<Organization, Role>]
  def member_organizations
    self.memberships.reduce({}) {|h, m| h[m.organization] = ((h[m.organization] ||= []) << m.role); h}
  end

  # #### JWT authentication
  # def self.find_for_jwt_authentication(sub)
  #   User.find_by(id: sub)
  # end

  # def jwt_subject
  #   self.id
  # end
  #
  # def jwt_payload
  #   # { email: self.email}
  # end

  # @param [Hash] hash
  def self.from_hash(hash)
    super(hash, [:email]) do |item, h|
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
