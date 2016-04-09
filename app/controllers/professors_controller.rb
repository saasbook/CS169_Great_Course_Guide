class ProfessorsController < ApplicationController

  def index
    @all_profs = Professor.all_profs
  end

  def show
    @prof = Professor.find(params[:id])
    @prof_courses = @prof.courses.order(rating: :desc)
  end

  def dist
    @dist_profs = Professor.dist_profs
  end
end
