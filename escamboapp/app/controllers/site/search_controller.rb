class Site::SearchController < SiteController
	def ads
		cookies[:search_term] = params[:q]

		# Search with Searchkick and Elasticsearch
		# @ads = Ad.search(params[:q], fields: [:title], page: params[:page], per_page: Ad::QTT_PER_PAGE)
		@ads = Ad.search(params[:q], params[:page])
		@categories = Category.all	

		# cookies[:categories] = @categories.to_json
	end
end
