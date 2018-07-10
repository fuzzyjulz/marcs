class HomeController < ApplicationController
  protect_from_forgery with: :exception
  
  def index
  end
  
  def become_a_member
  end
  
  def club_location
  end
  
  def faqs
  end
  
  def clear_caches
    Rails.cache.clear

    head :ok, content_type: "text/html"
  end
end
