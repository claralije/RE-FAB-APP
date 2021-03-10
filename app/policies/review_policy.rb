class ReviewPolicy < ApplicationPolicy
class Scope < Scope
  def resolve
      scope.all
  end

  end

  def create?
    user == record.deal.user && record.deal.status == 'closed' && !Review.find_by(deal: record.deal)
  end
end
