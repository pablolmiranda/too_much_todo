class Profile::TaskListsController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!, :except => [ :show ]
  before_filter :load_resource, :except => [:show, :new, :create]

  def show
    @todo_list = TodoList.find(params[:id])
    if @todo_list.is_private && @todo_list.user != current_user
      flash[:notice] = "You can't access this list"
      redirect_to profile_path(current_user)
    end
  end

  def edit
  end
  
  def update
    if @todo_list.update_attributes(params[:task_list])
      respond_with @todo_list do |format|
	flash[:notice] = "List updated"
        format.html { redirect_to profile_task_list_path(params[:profile_id], @todo_list)}
      end
    end
  end

  def destroy
    if !@todo_list.has_followers?
      @todo_list.destroy
      respond_with @todo_list do |format|
	flash[:notice] = "List #{@todo_list.name} was destroyed"
        format.html { redirect_to profile_path(current_user) }
      end
    else
      redirect_to root_path
    end
  end

  def new
    @todo_list = current_user.todo_lists.build()
    @todo_list.items.build
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
      if @todo_list.is_private?
	flash[:notice] = "You can not follow this list!"
      else
        current_user.follow!(@todo_list)
        flash[:notice] = "Now you are following the todo list #{@todo_list.name}."
      end
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

  protected
    def load_resource
      @todo_list = current_user.todo_lists.find(params[:id])
    end

end
