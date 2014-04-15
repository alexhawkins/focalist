class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
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
