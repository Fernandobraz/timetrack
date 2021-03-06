class ProjectsController < ApplicationController
  respond_to :html, :xml, :json
  # GET /projects
  # GET /projects.json
  def index
    @client = Client.find(params[:client_id])
    @can_see_all = ["Super Admin", "Recruitment Company Manager", "Recruirment Company Administrator"]
    if @can_see_all.include?(current_user.role)
      @projects = Project.where(client_id: @client.id)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @projects }
      end
    else
      if current_user.clients.include?(@client)
        @projects = Project.where(client_id: @client.id)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @projects }
        end
      elsif current_user.can_access?(@client)
        @projects = current_user.projects.where(client_id: @client.id)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @projects }
        end
      else
        redirect_to root_path, notice: "You don't have permission to see that."
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @client = Client.find(params[:client_id])
    @project = @client.projects.build
    
    respond_with(@project)
  end

  # GET /projects/1/edit
  def edit
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @client = Client.find(params[:client_id])
    @project = @client.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to client_projects_path(@client), notice: 'Project was successfully created.' }
        format.json { render json: client_projects_path(@client), status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: client_projects_path(@client).errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @client = Client.find(params[:client_id])
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to client_projects_path(@client), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: client_projects_path(@client).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  def assign_consultant
    @project = Project.find(params[:id])
    @consultants = User.where(role_id: Role.find_by_name("Consultant"))
  end
  
  private
  
  def project_params
    params.require(:project).permit(:client_id, :name, :user_ids => [])
  end
  
end
