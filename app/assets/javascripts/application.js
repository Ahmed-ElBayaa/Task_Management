// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree 

// function remove_fields(link) {
// 	alert("sure?");
// 	$(link).prev(".destroy_this").val("true");
// 	$(link).parents(".hide_this").hide();
// }

// function add_fields(link, association, content) {

//   var new_id = new Date().getTime();
//   content = content.replace(/new_____/g,""+new_id);
//   $(content).appendTo(".nested_attributes").ready(function(){      
//       $(".date").datepicker({ dateFormat: 'dd-mm-yy' });      
//   });
// }

$(document).ready(function(){

  $("#select_members").change(function(){

    var id = $(this).val();

    $("#members_list #save").before('<div class="new_member" value="' +
     id + '"><label>' + $("#select_members :selected").text() +
       '</label> <input type="hidden" name="members[]" value="'+ id +
       '"><br/></div>');
        
    $(this).find("option[value='" + id + "']").remove();
  });

  $("#members_list .new_member").live("click",function(){

    var value = $(this).attr('value');
    var name = $(this).children("label").text();
    
  	$(this).remove();

  	$("#select_members").append("<option value='" + value + "'>" +
  			name +"</option>");
  });

  $(".date").datepicker({ dateFormat: 'dd-mm-yy' });
});

$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field; 
  // it's a jQuery object already! Now you can find date input
  var dateField = field.find('.date');
  // and activate datepicker on it
  dateField.datepicker({ dateFormat: 'dd-mm-yy' });
});
 