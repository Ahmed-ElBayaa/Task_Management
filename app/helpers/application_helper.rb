module ApplicationHelper

	def link_to_remove_fields(name, b) 
		html = b.hidden_field(:_destroy, class: "destroy_this") 
		html += link_to_function name , "remove_fields(this)"		
	end

	def link_to_add_fields(name, f, association)

	    new_object = f.object.class.reflect_on_association(association).klass.new
	    
	    fields = f.fields_for(association, new_object,
	    	 :child_index => "new______#{association}") do |builder|
	      render(association.to_s.singularize, b: builder)
	    end
	    
	    link_to_function(name, "add_fields(this, \"#{association}\",
	    		 \"#{escape_javascript(fields)}\")")
    end
end
