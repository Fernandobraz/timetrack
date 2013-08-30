class TimesheetsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_timesheet, only: [:show, :edit, :update, :destroy]

  # GET /timesheets
  def index
    @project = Project.find(params[:project_id])
    @timesheets = Timesheet.where(project_id: @project.id)
  end

  # GET /timesheets/1
  def show
  end

  # GET /timesheets/new
  def new
    @project = Project.find(params[:project_id])
    @timesheet = @project.timesheets.build

    respond_with(@timesheets)
  end

  # GET /timesheets/1/edit
  def edit
  end

  # POST /timesheets
  def create
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.new(timesheet_params)

    if @timesheet.save
      redirect_to client_project_timesheets_path(@project.client_id, @project.id), notice: 'Timesheet was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /timesheets/1
  def update
    if @timesheet.update(timesheet_params)
      redirect_to @timesheet, notice: 'Timesheet was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /timesheets/1
  def destroy
    @timesheet.destroy
    redirect_to timesheets_url, notice: 'Timesheet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def timesheet_params
      params.require(:timesheet).permit(:project_id, :user_id, :day, :worked_hours)
    end
end
