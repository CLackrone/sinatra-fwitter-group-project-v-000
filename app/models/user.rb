class User < ActiveRecord::Base
	has_secure_password
	validates :username, :email, presence: true
	has_many :tweets

	def slug
		self.username.gsub(/\s/, ‘-‘).downcase
	end

	def self.find_by_slug(slug)
		self.all.find do |x|
			x.slug == slug
		end
	end

end