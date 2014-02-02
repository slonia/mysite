class Admin::TeachersController < AdminController
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
    if @teacher.save
      redirect_to [:admin, @teacher], notice: 'Teacher was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to [:admin, @teacher], notice: 'Teacher was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @teacher.destroy
    redirect_to admin_teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def teacher_params
      params.require(:teacher).permit([:id, :name, :surname, :patronymic, :cathedra_id, :degree])
    end
end
