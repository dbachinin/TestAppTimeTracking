class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @user = current_user
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = current_user
  end

  # GET /projects/new
  def new
    @project = Project.new
    @user = current_user
  end

  # GET /projects/1/edit
  def edit
    @user = current_user
  end

  # POST /projects
  # POST /projects.json
  def create
    @user = current_user
    # @project = Project.new(project_params)
    @project = @user.project.build(project_params)
    task = params[:project][:task]
    @project.tasks.push(task)
    respond_to do |format|
      if @project.save
        format.html { redirect_to [@user,@project], notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: [@user,@project] }
      else
        format.html { render :new }
        format.json { render json: [@user,@project].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to [@user,@project], notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user,@project] }
      else
        format.html { render :edit }
        format.json { render json: [@user,@project].errors, status: :unprocessable_entity }
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
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :tasks, :description, :uid, :user_id, { :task => []})
    end
end
