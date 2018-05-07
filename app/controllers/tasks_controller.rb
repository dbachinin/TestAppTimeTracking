class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_arrays

  def set_arrays
    @task_type = [["Error", 0],["Cosmetic", 1],["Exception", 2], ["Teature", 3],["Task", 4], ["Usability", 5], ["Performance", 6]]
    @task_priority = [["Emergency", 0], ["Critical", 1], ["Serious", 2], ["Regular", 3], ["Low", 4]]
  end

  # GET /tasks
  # GET /tasks.json
  def index
    # @tasks = Task.all
    @user = current_user
    @project = Project.find(params[:project_uid])
    @tasks = Task.where(project_id: @project.id)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = Task.find(params[:id]).coments
    @user = current_user
    @project = Task.find(params[:id]).project[0]
  end

  def edit_coments
    @comments = Task.find(params[:id]).coments
    @user = current_user
  end

  def add_coments
    @user = current_user
    @task = Task.find(params[:id])
    @coments = @task.coments
    @coment = params[:task][:coment]
    @coments.push(@coment)
  end

  def add_logs
    @user = current_user
    @logs = Task.find(params[:id]).logs    
  end
  # GET /tasks/new
  def new
    @user = current_user
    @project = Project.find_by(uid: params[:project_uid])
    @task = @project.build_task

  end

  # GET /tasks/1/edit
  def edit
    @user = current_user
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @user = current_user
    @project = Project.find(params[:project_uid])
    @task = @project.build_task(task_params)
    @task.coments.push(params[:task][:coment])
    @logs = @task.log
    # @logs.push(params[:task][:log])
    @task.creator = @user.id.as_json.values[0]
    @task.date_range = (Date.parse(@task.estimate_time)..Date.parse(@task.teken_time))
    @task.user_id = params[:task][:user_id][1..-1]
    @task.project_id = @project.id.as_json.values[0]
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @user = current_user
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:theme, :description, :date_range, :task_type, :task_priority, :estimate_time, :coments, :user_id, :creator, :project_id, :logs, :teken_time, :coment, :log)
    end
end
