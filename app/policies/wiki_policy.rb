class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    user.present? && ((user.admin? || record.user == user) || record.public?)
  end

  def edit?
    update?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  class Scope < Scope
    def resolve
      if !user.present? || user.standard?
        scope.where(public_records)
      elsif user.admin?
        scope.all
      elsif user.premium?
        scope.where(public_records.or(private_and_owned_records))
      end
    end

    private

    def table
      scope.arel_table
    end

    def private_and_owned_records
      table[:private].eq(true).and(table[:user_id].eq(user.id))
    end

    def public_records
      table[:private].eq(false)
    end


  end

end