class ItemsController < ApplicationController
  #enable the controller to be able to respond to html and javascript
  respond_to :html, :js

  def new
    @list = List.find(params[:list_id])
    @item = Item.new
  end


  def edit
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def create
    @list = List.find(params[:list_id])
    @item = current_user.items.build(item_params) 
    @item.list = @list
    @new_item = Item.new

    if @item.save
       #flash[:notice] = "Your new ITEM was saved"
       #redirect_to @list  #=> redirect_to list_path(@list)
    else
      #flash[:error] = "There was an error saving the item. Please try again"
      #render @list
      #render :new
    end
     #this overites the default behavior and instructs the controller to respond via Ajax
     respond_with(@item) do |f|
     f.html { redirect_to [@list] }
    end

  end

  def destroy
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])

    if @item.destroy
      # flash[:notice] = "Comment was removed."
      # redirect_to @list
      # check for the number of completed items after an item is destroyed
      # so that we can update our complete items count via javascript.
      # see destroy.js.erb for javascript call
      @completed_items_count = @list.items.where(complete: true).count
    else
      # flash[:error] = "Comment couldn't be deleted. Try again."
      # redirect_to @list
    end
    # this overites the default behavior and instructs the controller to respond via Ajax
    respond_with(@item) do |f|
     f.html { redirect_to @list }
    end
  end

  ############COMPLETE/INCOMPLETE ITEM TOGGLE##################
  def complete
    toggle # call toggle method to update our database attributes
    # check for the number of completed items after our datbase update
    # and store that value so that we can call it and update it simultaneously 
    @completed_items_count = @list.items.where(complete: true).count
    # once database updated, take care of Ajax call
    # if the client wants HTML in response to the complete_item action, we just
    # redirect them back to the list page that the action was called upon.
    # However, if the client wants Javascript(format.js), then it is an RJS request
    # and we render the RJS template associated with the template(in this case, it 
    # would be complete.js.erb)
    respond_to do |format|
      format.html { redirect_to @list }
      format.js
    end    
  end


  def incomplete #same as complete method
    toggle
    # check for the number of completed items after our datbase update
    # and store that value so that we can call it and update it simultaneously 
    @completed_items_count = @list.items.where(complete: true).count
    respond_to do |format|
      format.html { redirect_to @list }
      # if the client wants Javascript, then it is an RJS request and we render the RJS
      # template associated with the template, incomplete.js
      format.js
    end    
  end


  # update the sorting position of multiple items at once
  def sort
    params[:item].each_with_index do |id, index|
    Item.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end
  
  # responds when hide_list is triggered in lists/show and hides completed items
  # then renders RJS template, hide_list.js

  private

  def item_params
    params.require(:item).permit(:description)
  end

  # toggle method sets our Ojbect instance variables,
  # then calls update_complete method in the item model.
  # this allows us to toggle between boolean values for the
  # complete attribute in our database.
  def toggle
    @list = List.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @item.update_complete
  end

end