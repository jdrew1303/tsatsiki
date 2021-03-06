class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  #      :token_authenticatable,
  #      :encryptable,
  #      :confirmable,
  #      :lockable,
  #      :timeoutable,
  #      :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :invitable
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  
  
  
  has_many :projects
  has_many :authorized_projects
  
  
  
  validates_presence_of :username
  validates_format_of :username, :with => /\A[a-z0-9]+\Z/i
  
  
  
  def privileges_for(project)
    authorized_project = authorized_projects.where(:project_id => project.id).limit(1).first
    (authorized_project || AuthorizedProject.new).privileges
  end
  
  
  
  def self.find_for_database_authentication(conditions={})
    where(:username => conditions[:email]).limit(1).first ||
    where(:email => conditions[:email]).limit(1).first
  end
  
  
  
end
