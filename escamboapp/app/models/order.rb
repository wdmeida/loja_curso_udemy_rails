class Order < ApplicationRecord
 	
 	# Statuses payment transactions
 	enum :status => [:requested,
 					 :waiting,
 					 :analysing, 
 					 :paid, 
 					 :avaliable,
 					 :dispute, 
 					 :returned, 
 					 :canceled, 
 					 :debited, 
 					 :temporaty_retention]

 	# Associations
  	belongs_to :ad
	belongs_to :buyer, :class_name => "Member"
end
