class Professor < ActiveRecord::Base
    has_many :professor_courses
end
