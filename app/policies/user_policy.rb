class UserPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      scope.where(id: user.id)
    end

  end

  protected

  def can_read?
    user.id == record.id
  end

  def can_edit?
    user.id == record.id
  end

end