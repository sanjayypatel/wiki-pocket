class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where( :private => false )
      end
    end
  end

end