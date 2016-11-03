class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable, authentication_keys: [:fai]
  validates :fai,  :presence => true
  
  has_many :user_wings, dependent: :destroy
  accepts_nested_attributes_for :user_wings
  
  def known_by_first_name
    known_by.nil? ? first_name : known_by
  end
  
  def external_email()
    case committee_position
    when "President"
      "marcs.president@gmail.com"
    when "Treasurer"
      "marcs.treasurer@gmail.com"
    when "Secretary"
      "marcs.clubsecretary@gmail.com"
    when "Vice President"
      "marcs.vp@gmail.com"
    else
      ""
    end
  end
  
  def self.get_committee_members
    User.where("committee_position IS NOT NULL and committee_position != ''")
  end
  
  def self.financial_memebers
    User.where(financial: "y")
  end
  
  def self.plane_instructors
    financial_memebers.where(club_instructor_type: ["f","b"])
  end

  def self.heli_instructors
    financial_memebers.where(club_instructor_type: ["h","b"])
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(fai) = :value", { :value => fai.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
  
  def self.save_from_member(member)
    unless (member.nil? or member.fai.nil?)
      user = User.find_by(fai: member.fai)
      
      if (user.nil?)
        user = User.new({
          password: member.last_name.downcase,
          password_confirmation: member.last_name.downcase
        }.merge(member.attributes_to_user))
        user.save!(validate: false)
      else
        user.update!(member.attributes_to_user)
      end
    end
  end
  
  def email_required?
      false
  end
  
  def financial?
    financial=="y"
  end
  
  def member_fields
    attributes.reject do |key, value|
      ["encrypted_password", "reset_password_token", "reset_password_sent_at","remember_created_at",
        "sign_in_count","current_sign_in_at","last_sign_in_at","current_sign_in_ip",
        "last_sign_in_ip","failed_attempts","unlock_token","locked_at","created_at","updated_at",
        "profile_image"].include? key
    end
  end
  
  def changed_member_fields
    previous_changes.reject do |key, value|
      key == "updated_at"
    end
  end
end
