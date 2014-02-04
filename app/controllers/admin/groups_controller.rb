class Admin::GroupsController < AdminController
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
    if @group.save
      redirect_to [:admin, @group], notice: 'Group was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @group.update(group_params)
      redirect_to [:admin, @group], notice: 'Group was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_url, notice: 'Group was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name, :term, lesson_attributes: [:id, :day, :number, :on_second_week, :second_group, :subject_id, :teacher_id, :room_id, :lesson_id, :_destroy])
    end
end
