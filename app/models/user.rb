class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :collaborations
  has_many :wikis
  has_many :shared_wikis, through: :collaborations, source: :wiki

  validates :username, uniqueness: true

  scope :all_except, -> (user){ where.not(id: user) }
  scope :exclude_collaborators, -> (wiki){where.not(id: wiki.users)}

  after_initialize :init

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end

  def is_owner_of?(wiki)
    admin? || (premium? && (wiki.user == self || wiki.new_record?))
  end

  def init
    self.role ||= 'standard'
  end

  def upgrade
    self.update_attribute(:role, 'premium')
  end

  def downgrade
    private_wikis = self.wikis.only_private
    private_wikis.each { |wiki| wiki.make_public }
    self.update_attribute(:role, 'standard')
  end

end
