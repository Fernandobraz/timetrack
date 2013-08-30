class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body
  
  belongs_to :roles
  has_and_belongs_to_many :clients
  has_many :timesheets
  
  def name
    name = self.first_name.first.upcase + "." + self.last_name.capitalize
  end
  
  def role
    role = Role.find(self.role_id).name
  end
  
end
