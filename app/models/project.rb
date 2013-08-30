class Project < ActiveRecord::Base
  # attr_accessible :client_id, :name
  belongs_to :client
  has_many :timesheets
end
