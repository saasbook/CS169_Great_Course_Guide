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

    def self.splitByColon course
        index = course.index ":"
        course_number = course[0..(index-1)]
        title = course[(index + 2)..(course.length - 1)]
        return title, course_number
    end
end
