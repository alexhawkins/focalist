class Item < ActiveRecord::Base
  # the list method will be availabe to call on Item objects. It will return the list
  # associated with the given item.
  belongs_to :list
  belongs_to :user
  # an item can have many votes(namely one that is either true or false) and that 
  # a votes should not exis without an Item
  #has_many :votes, dependent: :destroy
  validates :user, presence: true
  # scope list items based on creation time
  #default_scope { order('created_at DESC') }
  # scope for list of items that have been checked as completed
  scope :position, -> { order('position') }
  scope :created, -> { order('created_at DESC') }

  # scope for list of items that have been set to the default :complete = true
  # Chain created scope within completed scope
  scope :completed, -> { created.where(complete: true) }
  # scope for list of items that have been set to the default :complete = false
  # Chain position and created scope within incomplete scope
  scope :incomplete, -> { position.created.where(complete: false) }
  # scope for position items for sortable/draggable lists

 

  def update_complete
    # checks to see if the Item's :complete attribute is true
    if self.complete
      # if complete is arleady true, then update it to false
      self.update_attribute(:complete, false)
    else
      # if complete is already false(which is usually the case since the attribute has
      # a default value of false making it incomplete) update the complete attribute to
      # true. This will allow the user to toggle between complete and incomplete items in
      # their respective lists. 
      self.update_attribute(:complete, true)
    end
  end

end