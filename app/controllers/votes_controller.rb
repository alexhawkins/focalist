class VotesController < ApplicationController
  respond_to :html, :js

  # the setup method will be called before every other method in votes_controller.rb,
  # thus setting the proper instance variables for each vote
  before_filter :setup

  def complete
    update_vote(false)
    respond_to do |format|
      format.html { redirect_to @list }
      format.js
    end    
  end

  def incomplete
    update_vote(true)
    respond_to do |format|
      format.html { redirect_to @list }
      format.js
    end 
  end

  ####################PRIVATE PARTS######################
  private

  # the setup method will be called before every other method in votes_controller.rb,
  # thus setting the proper instance variables for each vote
  def setup
    # Just like other controllers, grab the parent objects
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:item_id])

    # Look for an existing vote by this person so we don't create multiple
    @vote = @item.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)

    if @vote # if it exists, update it
      # only members of Focalist can vote. Not required to make work
      # but might as well check
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else # create it
      #authorize create by making sure that  a user is at least present(see application_policy)
      #authorize @vote
      @vote = current_user.votes.create(value: new_value, item: @item)
    end
  end

end