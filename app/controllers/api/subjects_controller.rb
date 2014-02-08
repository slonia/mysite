class Api::SubjectsController < ApplicationController
  load_resource

  respond_to :json

  def for_term
    @subjects = Subject.where("? = ANY (terms)", params[:term])
    render json: @subjects.to_json(except: [:created_at, :updated_at],
      include: {teachers: { except: [:created_at, :updated_at] } })
  end

  def show
    render json: @subject
  end

  def teachers
    render json: @subject.teachers
  end
end
