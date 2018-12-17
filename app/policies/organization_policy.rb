class OrganizationPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      user.organizations
    end

  end

  protected

  def can_read?
    record.users.include?(user)
  end

  def can_edit?
    can_read? && user.is_authorized?('admin')
  end

end