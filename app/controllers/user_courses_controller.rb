class UserCoursesController < ApplicationController

  def create
    @user = User.find_by(uid: session[:cas_user])
    input_course = params[:course]
    input_taken = params[:taken]
    if not input_course.to_s.empty?
      attrs = Utils.split_by_colon(input_course)
      if course = @user.user_courses.where(:title => attrs[0]).first
        course.update_attribute(:taken, input_taken)
      else
        @user.user_courses.create(title: attrs[0], number: attrs[1], taken: input_taken)
      end
    end
    redirect_to user_path and return
  end

  def destroy
    @user.user_courses.where(:id => params[:id]).destroy_all
    redirect_to user_path and return
  end
end