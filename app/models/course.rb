class Course < ActiveRecord::Base
    has_many :prereqs

    def compute_prereqs_given_user user
        prereqs = []
        self.prereqs.each {|prereq|
            if not user.user_courses.include? prereq
                prereqs << prereq.number
            end}
        prereqs
    end
end
