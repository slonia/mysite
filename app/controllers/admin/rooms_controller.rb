class Admin::RoomsController < AdminController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @room.save
      redirect_to [:admin, @room], notice: 'Room was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @room.update(room_params)
      redirect_to [:admin, @room], notice: 'Room was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_url, notice: 'Room was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit([:id, :number])
    end
end
