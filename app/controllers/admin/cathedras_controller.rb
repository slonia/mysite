class Admin::CathedrasController < ApplicationController
  load_and_authorize_resource except: :create
  # GET /admin/cathedras
  # GET /admin/cathedras.json
  def index
  end

  # GET /admin/cathedras/1
  # GET /admin/cathedras/1.json
  def show
  end

  # GET /admin/cathedras/new
  def new
  end

  # GET /admin/cathedras/1/edit
  def edit
  end

  # POST /admin/cathedras
  # POST /admin/cathedras.json
  def create
    @cathedra = Cathedra.create(admin_cathedra_params)
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

  # PATCH/PUT /admin/cathedras/1
  # PATCH/PUT /admin/cathedras/1.json
  def update
    respond_to do |format|
      if @cathedra.update(admin_cathedra_params)
        format.html { redirect_to @cathedra, notice: 'Cathedra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cathedra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/cathedras/1
  # DELETE /admin/cathedras/1.json
  def destroy
    @cathedra.destroy
    respond_to do |format|
      format.html { redirect_to admin_cathedras_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cathedra_params
      params[:cathedra].permit([:number, :name, :description])
    end
end
