class TaskListController < ApplicationController
  respond_to :html, :js
  responders :flash 
  before_filter :authenticate_user!, :except => [:show]
  def new
    @todo_list = current_user.todo_lists.build()
  end

  def create
    task_list = current_user.todo_lists.build(params["task_list"])
    if task_list.save
      respond_with task_list do |format|
	format.html { redirect_to profile_path(current_user) }
      end
    else
      render :new
    end
  end

  def follow
    @todo_list = TodoList.find(params[:id])
    if @todo_list
      current_user.follow!(@todo_list)
      flash[:notice] = "Now you are following the todo list #{@todo_list.name}"
      respond_with @todo_list do |format|
	format.html { redirect_to profile_path(@todo_list.user) }
	format.js
      end
    end
  end

  def unfollow
    @todo_list = TodoList.find(params[:id])
    if @todo_list
      current_user.unfollow!(@todo_list)
      flash[:notice] = "You unfollow the todo list #{@todo_list.name}"
      respond_with @todo_list do |format|
	format.html { redirect_to profile_path(@todo_list.user) }
	format.js
      end
    end
  end

end
