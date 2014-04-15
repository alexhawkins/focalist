class Item < ActiveRecord::Base
  # the list method will be availabe to call on Item objects. It will return the list
  # associated with the given item.
  belongs_to :list
  belongs_to :user

  default_scope { order('created_at DESC') }
end