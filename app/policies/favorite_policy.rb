class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
    def create?
      !Favorite.find_by(product: record.product, user: user)
    end

    def destroy?
      Favorite.find_by(product: record.product, user: user)
    end
end
