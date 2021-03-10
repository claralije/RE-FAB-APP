class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user == record.user || user == record.product.user
  end

  def create?
    user != record.product.user && !Deal.find_by(product: record.product)
  end

  def close?
    record.status != 'closed' && user == record.product.user
  end
end
