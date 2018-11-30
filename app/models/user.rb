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

  has_many :memberships

  # @param [Group] group
  def roles_for(group)
    group_list = group.ancestors
    member_groups.select {|g, _| group_list.include?(g)}.map {|_, r| r}.flatten.unique
  end

  def is_authorized?(role, group)
    self.roles_for(group).include?(role.id)
  end

  def add_role(role, group)
    m = self.memberships.find_by(group: group, role: role)
  end

  def del_role(role, group)
    m = self.memberships.find_by(group: group, role: role)
    m&.destroy!
  end

  def self.from_token_request(request)
    puts request.params['auth']
    return nil unless (r = request.params['auth'])
    self.find_by(username: r['username']) || self.find_by(email: r['email'])
  end

  def self.from_token_payload(payload)
    user_id = payload['user_id']
    self.find(user_id)
  end

  def to_token_payload
    { user_id: id }
  end

  # @return [{Group, [Role]}]
  def member_groups
    self.memberships.reduce({}) {|h, m| h[m.group] = ((h[m.group] ||= []) << m.role)}
  end

  def self.from_hash(hash)
    super(hash, [:username, :email])
  end

end
