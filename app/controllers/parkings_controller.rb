class ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :edit, :update, :destroy]

  # GET /parkings
  # GET /parkings.json
  def index
    @parkings = Parking.all
  end

  # GET /parkings/1
  # GET /parkings/1.json
  def show
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings
  # POST /parkings.json
  def create
    @parking = Parking.new(parking_params)

    respond_to do |format|
      if @parking.save
        format.html { redirect_to @parking, notice: 'Parking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parking }
      else
        format.html { render action: 'new' }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parkings/1
  # PATCH/PUT /parkings/1.json
  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to @parking, notice: 'Parking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parkings/1
  # DELETE /parkings/1.json
  def destroy
    @parking.destroy
    respond_to do |format|
      format.html { redirect_to parkings_url }
      format.json { head :no_content }
    end
  end

    # POST /queue_model/1/book.json
  def book
    @verif=Booking.where(uid: session[:user_id], pid: params[:id])
    if @verif!=nil
          @booking = Booking.new
          @booking.uid=session[:user_id]
          # On précise que cet object Booking dépend de la queue concernée
          @booking.pid = params[:id]
          @booking.time = Time.now 

          @parking = Parking.find(params[:id])
          @parking.taken=@parking.taken+1
          @parking.save

          respond_to do |format|
            if @booking.save
              format.json 
            else
              format.json { render json: @booking.errors, status: :unprocessable_entity }
            end
          end
    else
      format.json { render json: @booking.errors, status: :unprocessable_entity }
    end
  end

  def endbook
    @booking= Booking.where(queue_model_id: params[:id], user_id: session[:user_id]).take!
    @booking.end = Time.now

    @queue_model = QueueModel.find(params[:id])
    @queue_model.num_customer=Booking.where(queue_model_id: params[:id], end: nil).count
    @queue_model.save
    respond_to do |format|
      if @booking.save
        format.json
      else
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking
      @parking = Parking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_params
      params.require(:parking).permit(:name, :address, :lon, :lat, :price, :total, :taken)
    end
end
