class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable, authentication_keys: [:fai]
  validates :fai,  :presence => true
  
  has_many :user_wings, dependent: :destroy
    
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(fai) = :value", { :value => fai.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
