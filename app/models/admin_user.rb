# frozen_string_literal: true

class AdminUser < ApplicationRecord

  devise :database_authenticatable, :registerable, :validatable

  # password validation
  # validates_length_of :password, minimum: 6, allow_nil: true, on: :update
  # validates_length_of :password, minimum: 6, allow_nil: false, allow_blank: false, on: :create
  # validates_confirmation_of :password, allow_nil: false, allow_blank: false

  # sanitize email and username
  before_validation do
    self.email = self.email.to_s.downcase
  end

  validates_presence_of :email
  validates_uniqueness_of :email

  def self.from_hash(hash)
    self.create_from_hash(hash.cleanup, [:email])
  end

end
