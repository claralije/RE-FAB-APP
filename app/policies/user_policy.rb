class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end
end
