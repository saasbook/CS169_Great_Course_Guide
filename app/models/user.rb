class User < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {
	case_sensitive: false
  }
  validates :uid, presence: true, uniqueness: true
  #validates_associated :courses, on: :create

  def self.all_emails
  	emails = []
    self.all.each do |user|
      emails << user.email
    end
    return emails
  end
end
