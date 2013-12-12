class DragonsController < ApplicationController

  def index
    @dragons = Dragon.all
  end

  def show
    @dragon = Dragon.find(params[:id])
  end

  def new
    @dragon = Dragon.new
  end

  def edit
    @dragon = Dragon.find(params[:id])
  end

  def create
    params[:dragon][:user_id] = current_user.id
    @dragon = Dragon.new(params[:dragon])
    if @dragon.save
      redirect_to dragon_url(@dragon)
    else
      @errors = @dragon.errors.full_messages
      render :new
    end
  end

  def update
    @dragon = Dragon.find(params[:id])
    if @dragon.update_attributes(params[:dragon])
      redirect_to dragon_url(@dragon)
    else
      @errors = @dragon.errors.full_messages
      render :edit
    end
  end

  def destroy
    Dragon.destroy(params[:id])
    redirect_to dragons_url
  end
end
