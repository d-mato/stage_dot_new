class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume

  # GET /resume
  # GET /resume.json
  def show
  end

  # GET /resume/edit
  def edit
  end

  # PATCH/PUT /resume
  # PATCH/PUT /resume.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to resume_path, flash: { success: 'Resume was successfully updated.' } }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resume
    @resume = current_user.resume
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resume_params
    params.require(:resume).permit(:body)
  end
end
