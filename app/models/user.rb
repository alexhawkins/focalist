class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # :confirmable
  has_many :lists
  has_many :items, dependent: :destroy
  #has_many :votes, dependent: :destroy

  def role?(base_role)
    role == base_role.to_s
  end

# the checked method takes an item object and returns a checked object if the
# if the item argument has an associated record in the checked table. If 
# there is no check for the given item and user, the method will return nil.
# This will allow us to toggle between checked/unchecked links 
end
