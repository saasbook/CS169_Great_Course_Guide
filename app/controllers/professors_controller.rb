class ProfessorsController < ApplicationController

  def index
    @all_profs = Professor.all_profs("EECS")
  end

  def show
    @prof = Professor.find(params[:id])
    @prof_courses = @prof.courses.order(rating: :desc)
    @uniq_prof_courses = @prof.unique_courses
    @terms_and_ratings = @prof.chart_info 
    #already ordered (term-wise) (data for graphs)
  end

  def distinguished
    @dist_eecs_profs = Professor.dist_profs("EECS")
    @awarded_hum_profs = Professor.awarded_hum_profs
  end
end
