class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

 def show
    @item = Item.find params[:id]
  end

  def new
    @item = Item.new
  end


  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: 'Your new ITEM was saved'
    else
      flash[:error] = "There was an eroor saving the item. Please try again"
      render :new
    end
  end

  def update
  end

  def destroy
  end


  private

  def item_params
    params.require(:item).permit(:description)
  end
end