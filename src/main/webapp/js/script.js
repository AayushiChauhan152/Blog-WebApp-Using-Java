
// to edit user-profile
$(document).ready(function(){
	
	let edit=false;
	
	$('#edit-profile').click(function(){
		
		if(edit==false){		
			$('#profile-detail').hide();
			$('#profile-edit').show();
			edit=true;
			$(this).text("Ok")
		}else{
			$('#profile-detail').show();
			$('#profile-edit').hide();
			edit=false;
			$(this).text("Edit")
		}
	})
})


