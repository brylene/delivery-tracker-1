class DeliveriesController < ApplicationController
  def index
    matching_deliveries = Delivery.all

    @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })

    render({ :template => "deliveries/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    #render({ :template => "deliveries/show.html.erb" })
    redirect_to("/")
  end

  def create
    the_delivery = Delivery.new
    the_delivery.user_id = session.fetch(:user_id)
    the_delivery.description = params.fetch("query_description")
    the_delivery.date = params.fetch("query_supposed_to_arrive_on")
    the_delivery.details = params.fetch("query_details")
    the_delivery.status = "Waiting on"

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/", { :notice => "Added to list" })
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @the_delivery = Delivery.where({ :id => the_id }).at(0)

    if @the_delivery.status == "Waiting on"
      @the_delivery.status = "Received"
    end

    if @the_delivery.valid?
      @the_delivery.save
      redirect_to("/", { :notice => "Delivery updated successfully."} )
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/", { :notice => "Delivery deleted successfully."} )
  end
end
