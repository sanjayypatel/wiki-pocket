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
      if !user.present?
        public_records
      elsif user.standard?
        public_records + shared_records
      elsif user.admin?
        scope.all
      elsif user.premium?
        public_records + private_and_owned_records + shared_records
      end
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


  end

end