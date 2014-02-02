class Admin::SubjectsController < AdminController
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
    if @subject.save
      redirect_to [:admin, @subject], notice: 'Subject was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to [:admin, @subject], notice: 'Subject was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @subject.destroy
    redirect_to admin_subjects_url, notice: 'Subject was successfully destroyed.'
  end

  private

    def subject_params
      params.require(:subject).permit([:id, :name, terms: [], teacher_ids: []])
    end
end
