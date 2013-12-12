class DragonRentalRequestsController < ApplicationController
  include DragonRentalRequestsHelper
  def index
    @dragon_rental_requests = DragonRentalRequest.all
    @dragon_rental_requests.sort_by! { |request| request.start_date }
  end

  def show
    @dragon_rental_request = DragonRentalRequest.find(params[:id])
  end

  def edit
    @dragons = Dragon.all
    @dragon_rental_request = DragonRentalRequest.find(params[:id])
  end

  def new
    @dragons = Dragon.all

    @dragon_rental_request = DragonRentalRequest.new
  end

  def update
    @dragon_rental_request = DragonRentalRequest.find(params[:id])
    if @dragon_rental_request.update_attributes(params[:dragon_rental_request])
      redirect_to dragon_rental_request_url(@dragon_rental_request)
    else
      @errors = @dragon_rental_request.errors.full_messages
      @dragons = Dragon.all
      render :edit
    end
  end

  def create
    @dragon_rental_request = DragonRentalRequest.new(params[:dragon_rental_request])
    if @dragon_rental_request.save
      redirect_to dragon_rental_request_url(@dragon_rental_request)
    else
      @errors = @dragon_rental_request.errors.full_messages
      render :new
    end
  end

  def destroy
    DragonRentalRequest.destroy(params[:id])
    redirect_to dragon_rental_requests_url
  end

  def approve
    DragonRentalRequest.find(params[:id]).approve!
    redirect_to dragon_rental_requests_url
  end

  def deny
    DragonRentalRequest.find(params[:id]).deny!
    redirect_to dragon_rental_requests_url
  end
end
