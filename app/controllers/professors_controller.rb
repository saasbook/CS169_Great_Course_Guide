class ProfessorsController < ApplicationController

  def index
    @all_profs = Professor.all_profs("EECS")
  end

  def show
    @prof = Professor.find(params[:id])
    @prof_courses = @prof.courses.order(rating: :desc)
    @uniq_prof_courses = @prof.unique_courses
  end

  def distinguished
    @dist_eecs_profs = Professor.dist_profs("EECS")
    @dist_hum_profs = Professor.dist_profs("HUM")
  end
end
