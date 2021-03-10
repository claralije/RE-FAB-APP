class MessagePolicy < ApplicationPolicy
  class Scope < Scope
  def resolve
      scope.all
  end
  end

  def create?
    record.chatroom.user_a == user || record.chatroom.user_b == user
  end
end
