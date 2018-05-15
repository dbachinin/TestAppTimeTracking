class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /projects
  # GET /projects.json
  def index
    if current_user.admin
      @projects = Project.all
      @user = current_user
    else
      @user = current_user
      @projects = Project.find(Task.where(user_id: @user.id.as_json.values[0]).map{|i|i.project_id})
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @task_type = [["Error", 0],["Cosmetic", 1],["Exception", 2], ["Teature", 3],["Task", 4], ["Usability", 5], ["Performance", 6]]
    @task_priority = [["Emergency", 0], ["Critical", 1], ["Serious", 2], ["Regular", 3], ["Low", 4]]
    @user = current_user
    @tasks = Task.where(project_id: @project.id.as_json.values[0])
  end

  # GET /projects/new
  def new
    if current_user.admin
      @project = Project.new
      @user = current_user
    else
      flash.notice = "You dont have permisions"
      redirect_to user_projects_path(current_user)
    end
  end

  # GET /projects/1/edit
  def edit
    @user = current_user
    @uid = @project.uid
  end

  # POST /projects
  # POST /projects.json
  def create
    @user = current_user

    @project = Project.create(project_params)
    respond_to do |format|
      if @project.save
        # format.js
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @user = current_user
    @project = Project.find(params[:uid])
    @project.uid = @project.uid_back
    # @project.tasks = params[:project][:task][1..-1]
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project.uid), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: project_path(@project.uid) }
      else
        format.html { render :edit }
        format.json { render json: project_path(@project.uid).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @user = current_user
    @project.destroy
    respond_to do |format|
      format.html { redirect_to user_projects_url(@user), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      if params[:uid]&.gsub(/\s+/, "")&.length == 7
        @project = Project.find_by(uid: params[:uid].gsub(/\s+/, ""))
      else
        @project = Project.find(params[:uid])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.permit(:id, :project_name, :description, :uid, :user_ids, :uid_back)
    end
end
