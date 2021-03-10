class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    other_user = record.user_a == user ? record.user_a : record.user_b
    #user.chatrooms.where(user_a: other_user).or.where(user_b: other_user).empty?
    !user.chat_with(other_user)
  end

  def show?
    user == record.user_a || user == record.user_b
  end
end
