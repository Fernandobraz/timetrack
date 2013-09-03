class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :setup_client]
  # before_filter :check_permissions, :only => [:new, :create, :cancel]
  # skip_before_filter :require_no_authentication

  # def check_permissions
  #   authorize! :create, resource
  # end
  
  # GET /clients
  def index
    @can_see_all = ["Super Admin", "Recruitment Company Manager", "Recruirment Company Administrator"]
    if @can_see_all.include?(current_user.role)
      @clients = Client.all
    elsif current_user.role == "Consultant"
      @clients = []
      current_user.projects.each do |p|
        @clients << p.client if !@clients.include?(p.client)
      end
    else
      @clients = current_user.clients
    end
  end

  # GET /clients/1
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path, notice: 'Client was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: 'Client was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end
  
  def setup_client
    @recruiters = User.where(role_id: Role.where(name: "Recruitment Company Recruiter"))
    @user_clients = User.where(role_id: Role.where(name: "Client"))
    @authorisers = User.where(role_id: Role.where(name: "Authoriser"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:name, :recruiter_id, :user_ids => [])
    end
end
