class ItemsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @items = @list.items

    @item = @items.build(item_params) 


    if @item.save
      redirect_to items_path, notice: 'Your new ITEM was saved'
    else
      flash[:error] = "There was an error saving the item. Please try again"
      render :new
    end
  end

  def destroy
  end


  private

  def item_params
    params.require(:item).permit(:description, :list_id)
  end
end