class Profile::TaskListController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:profile_id])
    @todo_list = TodoList.find(params[:id]) 
  end

  def edit
    @todo_list = TodoList.find(params[:id]) rescue nil
    redirect_to profile_path(params[:profile_id]) unless @todo_list
  end
  
  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list
      items_attr = params[:task_list].delete(:todo_list_items_attributes)
      if @todo_list.update_attributes(params[:task_list])
	update_items(@todo_list, items_attr)
        respond_with @todo_list do |format|
	  flash[:notice] = "List updated"
          format.html { redirect_to profile_task_list_path(params[:profile_id], @todo_list)}
        end
      end
    end
  end

  protected
    def update_items(todo_list, items_attr)
      items_attr.each do |key, attrs|
	item = TodoListItem.find(attrs[:id]) rescue nil
	if item
	  item.udpate_attributes(attrs)
	else
	  p attrs
	  todo_list.todo_list_items.create(:text => attrs[:text])
	end
      end
    end

end
