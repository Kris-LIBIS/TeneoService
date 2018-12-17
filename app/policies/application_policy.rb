class ApplicationPolicy
  attr_reader :user, :record

  # @param [User] user
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user = user
    @record = record
  end

  def index?
    can_read?
  end

  def show?
    can_read?
  end

  def create?
    can_create?
  end

  def new?
    can_create?
  end

  def update?
    can_edit?
  end

  def edit?
    can_edit?
  end

  def destroy?
    false
  end

  protected

  def can_read?
    false
  end

  def can_edit?
    false
  end

  def can_create?
    false
  end

  class Scope
    attr_reader :user, :scope

    # @param [User] user
    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
