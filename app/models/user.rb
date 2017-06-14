class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable, authentication_keys: [:fai]
  validates :fai,  :presence => true
  
  has_many :user_wings, dependent: :destroy
  has_many :membership_years, dependent: :destroy
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
  
  def life_member?
    !membership_type.nil? and membership_type.downcase.include? "life"
  end
  
  def membership_type_sym
    if membership_type.nil?
      :senior
    elsif membership_type.downcase.include? "pensioner"
      :pensioner
    elsif membership_type.downcase.include? "student"
      :student
    elsif membership_type.downcase.include? "junior"
      :junior
    else
      :senior
    end
  end
  
  def membership_name
    "#{membership_type_sym.to_s.titleize} #{life_member? ? 'life':''} #{affiliate? ? 'Affiliate':''}"
  end

  def affiliate?
    !membership_type.nil? and membership_type.downcase.include? "affiliate"
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
    login = conditions.delete(:login)
    if login
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
  
  def non_renewal?
    financial=="-"
  end

  def committee_member?
    !(committee_position.nil? || committee_position=='')
  end
  
  def committee_executive?
    external_email != ""
  end

  def member_fields
    attributes.reject do |key, _value|
      ["encrypted_password", "reset_password_token", "reset_password_sent_at","remember_created_at",
        "sign_in_count","current_sign_in_at","last_sign_in_at","current_sign_in_ip",
        "last_sign_in_ip","failed_attempts","unlock_token","locked_at","created_at","updated_at",
        "profile_image"].include? key
    end
  end
  
  def changed_member_fields
    previous_changes.reject do |key, _value|
      key == "updated_at"
    end
  end
end
