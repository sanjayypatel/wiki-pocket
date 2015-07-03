class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :wikis
  validates :username, uniqueness: true

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

  def init
    self.role ||= 'standard'
  end

  def upgrade
    self.update_attribute(:role, 'premium') if self.standard?
  end

  def downgrade
    self.update_attribute(:role, 'standard') if self.premium?
  end

end
