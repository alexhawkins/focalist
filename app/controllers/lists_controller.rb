class ListsController < ApplicationController
  def index
    @lists = List.all
    #authorize @lists
  end

  def show
    @list = List.find(params[:id])
    # sort items based on incomplete, position and finally created scopes
    @items = @list.items.incomplete.position.created.where(user_id: current_user, list_id: @list.id) #create a scope for incomplete and complete
    # @completed_items = current_user.items.where(list_id: @list.id).completed
    # @items = current_user.items.incomplete.for_list(@list)

    # Show all completed items based on completed scope which will have a :complete database value of true
    @completed_items = @list.items.completed.where(user_id: current_user, list_id: @list.id)
    @item = Item.new
  end

  def new
    @list = List.new
    # authorize() will check the policy on new list resources via Pundit. 
    # If it's satisfied (in this case, if a user is present), 
    # it'll let the rendering continue. If not (if no user is present),
    # it'll throw an exception.
    authorize @list
  end

  def create
    @list = current_user.lists.build(list_params)
    authorize @list
    if @list.save
      redirect_to @list, notice: 'Your new LIST was saved'
    else
      flash[:error] = "There was an error saving the list. Please try again"
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      redirect_to @list, notice: 'List updated'
    else
      flash[:error] = "There was an error updating the list. Please try again"
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
