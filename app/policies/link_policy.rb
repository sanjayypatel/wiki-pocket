class LinkPolicy < ApplicationPolicy

  def show?
    user.present?
  end

  def index?
    show?
  end

  def new?
    show?
  end

  def create?
    show?
  end

  def create_link_with_wiki?
    show?
  end

  def edit?
    show? && !record.new_record?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

end