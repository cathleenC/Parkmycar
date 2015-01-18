class User < ActiveRecord::Base
	has_many :favorites
	has_many :parkings, through: :favorites
	has_one :booking
	has_one :parking, through: :booking
end
