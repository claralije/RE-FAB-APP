class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def new?
    return true
  end

  def update?
    user == record.user
  end

  def edit?
    update?
  end

  def destroy?
   user == record.user
  end
end
