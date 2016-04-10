require "spec_helper"
require "rails_helper"

describe ProfessorsController do

  User.destroy_all
  Professor.destroy_all
  Course.destroy_all

  CASClient::Frameworks::Rails::Filter.fake("123456")
end
