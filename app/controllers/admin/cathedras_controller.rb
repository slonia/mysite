class Admin::CathedrasController < AdminController
  load_and_authorize_resource

  def index
    @cathedras = @cathedras.page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @cathedra.save
        format.html { redirect_to [:admin, @cathedra], notice: 'Cathedra was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cathedra }
      else
        format.html { render action: 'new' }
        format.json { render json: @cathedra.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cathedra.update(cathedra_params)
        format.html { redirect_to [:admin, @cathedra], notice: 'Cathedra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cathedra.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cathedra.destroy
    respond_to do |format|
      format.html { redirect_to admin_cathedras_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cathedra_params
      params.require(:cathedra).permit([:number, :name, :description])
    end
end
