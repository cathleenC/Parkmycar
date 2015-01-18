class Favorite < ActiveRecord::Base
	belongs_to :parking
	belongs_to :user
end
