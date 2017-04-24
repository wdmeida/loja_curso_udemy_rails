class BackofficeController < ApplicationController
	before_action :authenticate_admin!

  	layout "backoffice"

  	# Subscribe current_user to Pundit
  	def pundit_user
  		current_admin # current_user to Pundit
  	end
end