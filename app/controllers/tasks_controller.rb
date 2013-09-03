class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:project_id])
    @timesheet = Timesheet.find(params[:timesheet_id])
    @task.timesheet_id = @timesheet.id
    if @task.save
      redirect_to client_project_timesheet_path(@client, @project, @timesheet), notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :date, :time, :comment, :worked_hours, :timesheet_id)
    end
end
