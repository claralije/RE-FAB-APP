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

  def closed?
    record.status != 'closed' && user == record.product.user
  end

  def in_process?
    user && user == record.product.user && record.status != 'in_process'
  end

  def rejected?
    user && user == record.product.user && record.status != 'rejected'
  end
end
