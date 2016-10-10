class GoogleMembershipDb
  def initialize()
    
    # Creates a session.
    @refresh_token = ApplicationHelper::GOOGLE_REFRESH_TOKEN
    #get_refresh_token() #use this to get a new refresh token 
    access_token = get_access_token_with_refresh_token(@refresh_token)
    @session = GoogleDrive.login_with_oauth(access_token)
  end
  
  def get_membership_sheet()
    @session.spreadsheet_by_key(ApplicationHelper::GOOGLE_MEMBERSHIP_SPREADSHEET_KEY).worksheets[0]
  end

  private
  def self.get_refresh_token()
    client = Google::APIClient.new
    auth = client.authorization
    auth.client_id = ApplicationHelper::GOOGLE_CLIENT_ID
    auth.client_secret = ApplicationHelper::GOOGLE_CLIENT_SECRET
    auth.scope = [
      "https://www.googleapis.com/auth/drive",
      "https://spreadsheets.google.com/feeds/"
    ]
    auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
    print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
    print("2. Enter the authorization code shown in the page: ")
    auth.code = $stdin.gets.chomp
    auth.fetch_access_token!
    
    print("3. This is your refresh token: %s\n\n" % auth.refresh_token)
  end
  
  def get_access_token_with_refresh_token(refresh_token)
    client = Google::APIClient.new
    auth = client.authorization
    auth.client_id = ApplicationHelper::GOOGLE_CLIENT_ID
    auth.client_secret = ApplicationHelper::GOOGLE_CLIENT_SECRET
    auth.scope = [
      "https://www.googleapis.com/auth/drive",
      "https://spreadsheets.google.com/feeds/"
    ]
    auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
    auth.refresh_token = refresh_token
    auth.fetch_access_token!
    auth.access_token
  end
end