class User < ActiveRecord::Base
	has_many :user_courses

	def self.all_emails
		emails = []
		self.all.each do |user|
			emails << user.email
		end
		return emails
	end
end
