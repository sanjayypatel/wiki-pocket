class LinkPolicy < ApplicationPolicy

  def show?
    user.present?
  end

  def new?
    show?
  end

  def create?
    show?
  end

end