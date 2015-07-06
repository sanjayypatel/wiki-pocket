class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    Wiki.where(:id => record.id).exists?
  end

  def update?
    user.present? && (
      record.public? || (
        user.admin? ||
        record.user == user ||
        record.users.include?(user)
      )
    )
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
      wikis = nil
      if !user.present?
        wikis = public_records
      elsif user.standard?
        wikis = (public_records + shared_records).uniq
      elsif user.admin?
        wikis = scope.all
      elsif user.premium?
        wikis = (public_records + private_and_owned_records + shared_records).uniq
      end
      return sorted_by_last_updated(wikis)
    end

    private

    def private_and_owned_records
      scope.where(:private => true).where(:user_id => user.id)
    end

    def public_records
      scope.where(:private => false)
    end

    def shared_records
      scope.joins(:collaborations).where("collaborations.user_id == #{user.id}")
    end

    def sorted_by_last_updated(records)
      records.sort_by{|e| e.updated_at }.reverse!
    end

  end

end