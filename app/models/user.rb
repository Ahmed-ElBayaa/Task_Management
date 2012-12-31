class User < ActiveRecord::Base

  has_and_belongs_to_many :projects
  has_many :tasks	


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :type, :email, :name, :password,
                       :password_confirmation, :remember_me

  def admin?
    self.type == 'Admin'
  end

end
