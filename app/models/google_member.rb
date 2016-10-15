class GoogleMember
  @@idx = 0
  FINANCIAL_IDX = (@@idx +=1)
  FAI_IDX = (@@idx +=1)
  LAST_NAME_IDX = (@@idx +=1)
  FIRST_NAME_IDX = (@@idx +=1)
  KNOWN_BY_IDX = (@@idx +=1)
  SECOND_NAME_IDX = (@@idx +=1)
  OCCUPATION_IDX = (@@idx +=1)
  STREET_IDX = (@@idx +=1)
  CITY_IDX = (@@idx +=1)
  POSTCODE_IDX = (@@idx +=1)
  DOB_IDX = (@@idx +=1)
  EMAIL_IDX = (@@idx +=1)
  HOME_PHONE_IDX = (@@idx +=1)
  MOBILE_PHONE_IDX = (@@idx +=1)
  MEMBERSHIP_TYPE_IDX = (@@idx +=1)
  AFFILIATES_CLUB_IDX = (@@idx +=1)
  PENSIONER_NO_IDX = (@@idx +=1)
  FIXED_WINGS_IDX = (@@idx +=1)
  GLIDER_WINGS_IDX = (@@idx +=1)
  HELI_WINGS_IDX = (@@idx +=1)
  MULTIROTOR_WINGS_IDX = (@@idx +=1)
  MAAA_INSTRUCTOR_IDX = (@@idx +=1)
  CLUB_INSTRUCTOR_IDX = (@@idx +=1)
  COMMITTEE_POSITION_IDX = (@@idx +=1)
  BLUE_KEY_IDX = (@@idx +=1)
  GREEN_KEY_IDX = (@@idx +=1)
  YELLOW_KEY_IDX = (@@idx +=1)
  DEPOSIT_COLLECTED_IDX = (@@idx +=1)
  DEPOSIT_RETURNED_IDX = (@@idx +=1)
  DATE_FEES_PAID_IDX = (@@idx +=1)
  RECIEPT_IDX = (@@idx +=1)
  CLUB_FEES_IDX = (@@idx +=1)
  VMAA_FEES_IDX = (@@idx +=1)
  KEY_DEPOSIT_IDX = (@@idx +=1)
  TOTAL_IDX = (@@idx +=1)
  PROFILE_IMAGE_IDX = (@@idx += 9)
  
  FIRST_ROW = 2
  
  attr_accessor :financial, :fai, :first_name, :last_name
  attr_accessor :street, :city, :postcode, :email
  attr_accessor :home_phone, :mobile_phone
  attr_accessor :wings, :maaa_instructor, :club_instructor_type
  attr_accessor :committee_position
  
  def initialize(sheet,row)
    @financial = sheet[row, FINANCIAL_IDX]
    @fai = nil_if_blank sheet[row, FAI_IDX]
    @first_name = sheet[row, FIRST_NAME_IDX]
    @known_by = nil_if_blank sheet[row, KNOWN_BY_IDX]
    @last_name = sheet[row, LAST_NAME_IDX]
    @street = sheet[row, STREET_IDX]
    @city = sheet[row, CITY_IDX]
    @postcode = sheet[row, POSTCODE_IDX]
    @email = sheet[row, EMAIL_IDX]
    @home_phone = sheet[row, HOME_PHONE_IDX]
    @mobile_phone = nil_if_blank sheet[row, MOBILE_PHONE_IDX]
    @user_wings = []
    @user_wings << UserWing.new(wing_type: "fixed", rank: sheet[row, FIXED_WINGS_IDX])
    @user_wings << UserWing.new(wing_type: "heli", rank: sheet[row, HELI_WINGS_IDX])
    @user_wings << UserWing.new(wing_type: "glider", rank: sheet[row, GLIDER_WINGS_IDX])
    @user_wings << UserWing.new(wing_type: "multirotor", rank: sheet[row, MULTIROTOR_WINGS_IDX])
    @maaa_instructor = sheet[row, MAAA_INSTRUCTOR_IDX].present?
    @club_instructor_type = nil_if_blank sheet[row, CLUB_INSTRUCTOR_IDX]
    @committee_position = nil_if_blank sheet[row, COMMITTEE_POSITION_IDX]
    @profile_image = nil_if_blank sheet[row, PROFILE_IMAGE_IDX]
  end
  
  def nil_if_blank(value)
    value.empty? ? nil : value
  end
  
  def self.get_member_by_fai(fai)
    processSheet {|sheet,row|
      if (sheet[row, FAI_IDX] == fai)
        return GoogleMember.new(sheet,row)
      end
    }
    return nil
  end
  
  def self.get_all_members()
    members = []
    processSheet {|sheet,row|
      unless (sheet[row, FINANCIAL_IDX].empty?)
        members << GoogleMember.new(sheet,row)
      end
    }
    return members
  end
  
  def attributes_to_user()
    instance_values
  end
  
  private
  def self.processSheet()
    sheet = GoogleConnection.new.get_membership_sheet
    (FIRST_ROW..sheet.num_rows).each do |row|
      yield(sheet,row)
    end
    return nil
  end

end