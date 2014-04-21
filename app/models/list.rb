class List < ActiveRecord::Base
  # example of dymnamic method create. We've create a method called items
  # which we can call on List objects. list.items
  has_many :items, dependent: :destroy
  belongs_to :user
 
  default_scope { order('created_at DESC') }
 
  def update_visible
    if self.visible #check to see is visible attribute is true
      self.update_attribute(:visible, false)
    else
      self.update_attribute(:visible, true)
    end
  end

end
