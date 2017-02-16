class InterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:new, :create]
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  def index
    @interviews = current_user.interviews.order(start_at: :desc)
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /companies/:company_id/interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /companies/:company_id/interviews
  # POST /companies/:company_id/interviews.json
  def create
    @interview = Interview.new(interview_params)
    @interview.company = @company

    respond_to do |format|
      if @interview.save
        format.html { redirect_to @interview, flash: { success: 'Interview was successfully created.' } }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to [@company, @interview], flash: { success: 'Interview was successfully updated.' } }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to [@interview.company, @interview], flash: { success: 'Interview was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_interview
    @interview = Interview.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def interview_params
    params.require(:interview).permit(:company_id, :category, :start_at, :impression)
  end
end
