class TaskListController < ApplicationController
  respond_to :html
  responders :flash 
  before_filter :authenticate_user!, :except => [:show]
  def new
    @todo_list = current_user.todo_lists.build()
  end

  def create
    task_list = current_user.todo_lists.build(params[:task_list]["todo_list"])
    if task_list.save
      respond_with task_list do |format|
	format.html { redirect_to profile_path(current_user) }
      end
    else
      render :new
    end
  end

end