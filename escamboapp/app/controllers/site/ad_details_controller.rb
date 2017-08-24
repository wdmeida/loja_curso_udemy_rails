class Site::AdDetailsController < SiteController
	def show
		@categories = Category.order_by_description
		@ad = Ad.find(params[:id])

		respond_to do |format|
			format.html
			format.pdf do
				render pdf: "#{@ad.title}",
				layout: 'pdf'
			end
		end
	end
end
