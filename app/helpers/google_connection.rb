class GoogleConnection
  def initialize()
    
    # Creates a session.
    @refresh_token = ApplicationHelper::GOOGLE_REFRESH_TOKEN
    #get_refresh_token() #use this to get a new refresh token 
    access_token = get_credentials_with_refresh_token(@refresh_token)
    @session = GoogleDrive.login_with_oauth(access_token)
  end
  
  def get_membership_sheet()
    @session.spreadsheet_by_key(ApplicationHelper::GOOGLE_MEMBERSHIP_SPREADSHEET_KEY).worksheets[0]
  end
  
  def get_photos_dirs()
    gallery = @session.collection_by_title("MARCS Gallery")
    gallery.subcollections
  end
  
  def get_minutes_dirs()
    minutes = @session.collection_by_title("MARCS Club Minutes")
    minutes.subcollections
  end
  
  def get_by_url(url)
    @session.collection_by_url(url)
  end

  private
  def self.get_basic_credentials()
    Google::Auth::UserRefreshCredentials.new(
          client_id: ApplicationHelper::GOOGLE_CLIENT_ID,
          client_secret: ApplicationHelper::GOOGLE_CLIENT_SECRET,
          scope: [
            "https://www.googleapis.com/auth/drive",
            "https://spreadsheets.google.com/feeds/",
          ],
          redirect_uri: "http://marcs.org/redirect")
  end
  
  def self.get_credentials()
    auth = GoogleConnection::get_basic_credentials
    print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
    print("2. Enter the authorization code shown in the page: ")
    auth.code = $stdin.gets.chomp
    auth.fetch_access_token!
    
    print("3. This is your refresh token: %s\n\n" % auth.refresh_token)
  end
  
  def get_credentials_with_refresh_token(refresh_token)
    credentials = GoogleConnection::get_basic_credentials
    credentials.refresh_token = refresh_token
    credentials.fetch_access_token!
    credentials
  end
end