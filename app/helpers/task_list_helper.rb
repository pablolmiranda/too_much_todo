module TaskListHelper
  def add_todo_list_item_link(form_builder, todo_list)
    link_to_function 'add Item' do |page|
      form_builder.fields_for :todo_list_items, todo_list.todo_list_items, :child_index => 'TODO_LIST_ITEM_ID' do |f|
	html = render(:partial => "shared/todo_list_item_form", :locals => { :form => f } )
	page << "$('#todo_list_items').append('#{ escape_javascript(html)}'.replace(/TODO_LIST_ITEM_ID/g, new Date().getTime()) );"
      end
    end
  end

  def remove_todo_list_item_link(form_builder)
    if form_builder.object.new_record?
      link_to_function('remove', "$(this).parent().remove()"); 
    else
      form_builder.hidden_field(:delete)
      link_to_function('remove', "$(this).parent().hide()")
    end
  end

end
