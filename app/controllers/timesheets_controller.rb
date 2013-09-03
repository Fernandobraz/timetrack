class TimesheetsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_timesheet, only: [:show, :edit, :update, :destroy]

  # GET /timesheets
  def index
    @project = Project.find(params[:project_id])
    @client = Client.find(params[:client_id]) 
    
    if !current_user.can_access?(@client)
      redirect_to root_path, notice: "You don't have permission to see that"
    end
    
    @can_see_all = ["Super Admin", "Recruitment Company Manager", "Recruirment Company Administrator"]
    if @can_see_all.include?(current_user.role)
      @timesheets = Timesheet.where(project_id: @project.id)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @timesheets }
      end
    else
      if current_user.projects.include?(@project)
        @timesheets = Project.where(client_id: @project.client_id).find(@project.id).timesheets.where(user_id: current_user)
      else
       redirect_to root_path, notice: "You don't have permission to see that."
      end
    end
  end

  # GET /timesheets/1
  def show
    @project = Project.find(params[:project_id])
    @client = Client.find(params[:client_id])
    @timesheet = Timesheet.find(params[:id])
    @tasks = @timesheet.tasks
  end

  # GET /timesheets/new
  def new

    @project = Project.find(params[:project_id])
    @timesheet = @project.timesheets.build
    @users = @project.users
    respond_with(@timesheets)
  end

  # GET /timesheets/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @users = @project.users
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
      redirect_to client_project_timesheets_path(@timesheet.project.client_id, @timesheet.project_id), notice: 'Timesheet was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /timesheets/1
  def destroy
    @timesheet.destroy
    redirect_to client_project_timesheets_path, notice: 'Timesheet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def timesheet_params
      params.require(:timesheet).permit(:project_id, :user_id, :start_date, :end_date, :submited?)
    end
end
