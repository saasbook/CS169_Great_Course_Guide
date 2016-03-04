class Course < ActiveRecord::Base
    has_many :prereqs
end
