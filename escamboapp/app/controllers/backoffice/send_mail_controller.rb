class Backoffice::SendMailController < ApplicationController

	def create
		begin
			AdminMailer.send_message(	current_admin, 
								 		params[:'recipient-text'], 
								 		params[:'subject-text'], 
								 		params[:'message-text']).deliver_now
			@notity_message = I18n.t('messages.send_mail_success')
			@notify_flag = I18n.t('flags.success')
		rescue
			@notify_message = I18n.t('messages.send_mail_error')
			@notify_flag = I18n.t('flags.error')
		end
		respond_to do |format|
			format.js
		end	
	end

	def edit
		@admin = Admin.find(params[:id])

		respond_to do |format|
			format.js
		end
	end

end
