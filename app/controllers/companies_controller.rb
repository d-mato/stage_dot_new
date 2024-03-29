class CompaniesController < AuthorizedController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :archive]

  # GET /companies
  # GET /companies.json
  def index
    @companies = current_user.companies.not_archived
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.user = current_user

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, flash: { success: 'Company was successfully created.' } }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, flash: { success: 'Company was successfully updated.' } }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, flash: { success: 'Company was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  # GET /companies/archives
  def archives
    @companies = current_user.companies.archived
  end

  # POST/DELETE /companies/1/archive
  def archive
    if request.post?
      @company.archive!
      msg = 'アーカイブしました'
    elsif request.delete?
      @company.restore!
      msg = 'アーカイブからリストアしました'
    end

    respond_to do |format|
      format.html { redirect_to @company, flash: { success: msg } }
      format.json { render json: @company }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = current_user.companies.find(params[:id] || params[:company_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :employee_count, :engineer_count, :notes, :good, :bad, :motivation, :via)
  end
end
