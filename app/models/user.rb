class User < ActiveRecord::Base
    has_many :user_courses
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :uid, presence: true, uniqueness: true
end
