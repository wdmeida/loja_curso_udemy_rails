class Site::HomeController < ApplicationController
  layout 'site'
  
  def index
  	@categories = Category.order_by_description
  	@ads = Ad.last_six_ads
  end
end
