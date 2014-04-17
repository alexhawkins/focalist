class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  # Should be submitted with a value of true(unchecked) or false(checked).
  # If value is anything other than true or false, then a message will be returned to the user.
  validates :value, inclusion: { in: [false, true], message: "%{value} is not a valid vote." }
  
  # we need to update the boolean value of each item after a user votes/checks the item to
  # be either complete or incomplete. We use the after_save callback  whic h will run
  # update_item private method every time a vote is saved. 
  after_save :update_item

  private
  # the update_item method calls a method named update_complete on a vote's item object which
  # will then change the boolean value of the :complete attribute in the item objects database
  # to either true or false. Depending the boolean value of complete, the item object will either
  # appear in the complete or incomplete item list which will be handled via scope sorting in
  # the item.rb model.
  def update_item
    self.item.update_complete
  end
end
