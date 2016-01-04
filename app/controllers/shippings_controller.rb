class ShippingsController < ApplicationController
  before_action :set_shipping, only: [:show, :edit, :update, :destroy]

  # GET /shippings
  # GET /shippings.json
  def index
    @shippings = Shipping.all
  end

  # GET /shippings/1
  # GET /shippings/1.json
  def show
  end

  # GET /shippings/new
  def new

  end

  # GET /shippings/1/edit
  def edit
  end

  def price
    shipping_id = params[:id] # Shipment ID
    @response = CANADA_POST_SERVICE.get_price(shipping_id)
  end

  def label
    label_url = params[:url] # Shipment ID
    response = CANADA_POST_SERVICE.get_label(label_url)
    send_data(response.body, filename: 'shipping_label.pdf')
  end

  def details
    shipping_id = params[:id] # Shipment ID
    @response = CANADA_POST_SERVICE.details(shipping_id)
  end

  # POST /shippings
  # POST /shippings.json
  def create
    @sender = params[:sender]
    @destination = params[:destination]
    @package = params[:package]
    @notification = params[:notification]
    @preferences = params[:preferences]
    @settlement_info = params[:settlement_info]
    @response = CANADA_POST_SERVICE.create(
        sender: @sender,
        destination: @destination,
        package: @package,
        notification: @notification,
        preferences: @preferences,
        settlement_info: @settlement_info,
        group_id: '5241556',
        mailing_date: '2016-01-10',
        contract_id: '2514533',
        service_code: params[:service_code]
    )
    unless @response[:errors].present?
      Shipping.track_shipping(@response)
    end
    respond_to do |format|
      format.js {}
    end
  end

  # PATCH/PUT /shippings/1
  # PATCH/PUT /shippings/1.json
  def update
    respond_to do |format|
      if @shipping.update(shipping_params)
        format.html { redirect_to @shipping, notice: 'Shipping was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipping }
      else
        format.html { render :edit }
        format.json { render json: @shipping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shippings/1
  # DELETE /shippings/1.json
  def destroy
    @shipping.destroy
    respond_to do |format|
      format.html { redirect_to shippings_url, notice: 'Shipping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shipping
    @shipping = Shipping.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shipping_params
    params[:shipping]
  end
end