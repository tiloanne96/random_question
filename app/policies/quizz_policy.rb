class QuizzPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def show?
    false
  end

  def create?
    true
  end

  def update?
    true
  end

  class Scope < ApplicationPolicy::Scope
  end
end
