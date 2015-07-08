class LinkPolicy < ApplicationPolicy

  def show?
    user_signed_in?
  end

end