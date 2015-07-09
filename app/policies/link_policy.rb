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

  def edit?
    update?
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

end