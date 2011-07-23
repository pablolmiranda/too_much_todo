class Profile::TaskListController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!, :except => [ :show ]

  def show
    @user = User.find(params[:profile_id]) rescue nil
    @todo_list = TodoList.find(params[:id]) rescue nil
    redirect_to root_path unless @user && @todo_list
  end

  def edit
    @todo_list = TodoList.find(params[:id]) rescue nil
    redirect_to profile_path(params[:profile_id]) unless @todo_list
  end
  
  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list
      items_attr = params[:task_list].delete(:items_attributes)
      if @todo_list.update_attributes(params[:task_list])
	update_items(@todo_list, items_attr)
        respond_with @todo_list do |format|
	  flash[:notice] = "List updated"
          format.html { redirect_to profile_task_list_path(params[:profile_id], @todo_list)}
        end
      end
    end
  end

  def destroy
    todo_list = TodoList.find(params[:id])
    if current_user == todo_list.user && !todo_list.has_followers?
      todo_list.destroy
      respond_with todo_list do |format|
	flash[:notice] = "List #{todo_list.name} was destroyed"
        format.html { redirect_to profile_path(current_user) }
      end
    else
      redirect_to root_path
    end
  end

  protected
    def update_items(todo_list, items_attr)
      if items_attr
	items_attr.each do |key, attrs|
	  item = TodoListItem.find(attrs[:id]) rescue nil
	  p item
	  p attrs
	  if item
	    if attrs[:_destroy].to_i == 1 
	      item.destroy
    	    else
	      attrs.delete(:_destroy)
	      item.update_attributes(attrs)
	    end
	  else
	    todo_list.items.create(:text => attrs[:text])
	  end
	end
      end
    end

end
