class ItemsController < ApplicationController
  respond_to :html, :js

  def index
    @items = Item.all
  end

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

    if @item.save
       flash[:notice] = "Your new ITEM was saved"
       redirect_to @list  #=> redirect_to list_path(@list)
    else
      flash[:error] = "There was an error saving the item. Please try again"
      render @list
      #render :new
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])

    if @list.destroy
      flash[:notice] = "Comment was removed."
      redirect_to items_path
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to items_path
    end

  end

  def complete
  end


  private

  def item_params
    params.require(:item).permit(:description)
  end
end