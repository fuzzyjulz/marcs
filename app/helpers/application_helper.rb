module ApplicationHelper
  DISPLAY_TIME_FORMAT = "%-d-%b-%Y %-l:%M%P"
  DISPLAY_DATE_FORMAT = "%-d-%b-%Y"
  FACEBOOK_CLIENT_ID = ENV["FB_CLIENT_ID"]
  FACEBOOK_SECRET = ENV["FB_SECRET"]
  GOOGLE_CLIENT_ID = ENV["GOOGLE_CLIENT_ID"]
  GOOGLE_CLIENT_SECRET = ENV["GOOGLE_CLIENT_SECRET"]
  GOOGLE_MEMBERSHIP_SPREADSHEET_KEY = ENV["GOOGLE_MEMBERSHIP_SPREADSHEET_KEY"]
  GOOGLE_REFRESH_TOKEN = ENV["GOOGLE_REFRESH_TOKEN"]
  CLUB_CALENDAR_ICS_URL = ENV["CLUB_CALENDAR"]
  COMMITTEE_CALENDAR_ICS_URL = ENV["COMMITTEE_CALENDAR"]
  GOOGLE_ANALYTICS_TRACKER = ENV["GOOGLE_ANALYTICS_TRACKER"]
end
