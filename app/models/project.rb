class Project < ActiveRecord::Base
  # attr_accessible :client_id, :name
  belongs_to :client
  has_many :timesheets
  has_and_belongs_to_many :users
end
