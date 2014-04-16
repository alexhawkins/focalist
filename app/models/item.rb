class Item < ActiveRecord::Base
  # the list method will be availabe to call on Item objects. It will return the list
  # associated with the given item.
  belongs_to :list
  belongs_to :user
  validates :user, presence: true
  # set default scope for listed items
  default_scope { order('created_at DESC') }
  # scope for list of items that have been checked as completed
  scope :completed, where(complete: true)
  # scope for list of items that have been set to the default :complete = false
  scope :incomplete, where(complete: false)
end