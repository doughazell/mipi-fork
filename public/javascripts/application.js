// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function delay_for_development_environment() {
    setTimeout(function () {
        
    }, 3000);
}
function mark_for_hide(element) {
    $(element).next('.should_hide').value = 1;
}

function edit_element_toggle(element_id, show) {
    if (show == 1) { // Show
        alert('Show!')
        document.getElementById(element_id).style.display = ''
    }
    else { // Hide
        document.getElementById(element_id).style.display = 'none'
    }
}

function edit_element(element_id) {
    document.forms[0].submit();
}

function switch_edits(element_id_1, element_id_2, bBlank) {
    debug = 0;
    e1 = document.getElementById(element_id_1);
    e1_region = document.getElementById(element_id_1 + '_region');
    e2 = document.getElementById(element_id_2);
    e2_region = document.getElementById(element_id_2 + '_region');
    err = document.getElementById('error_message_' + element_id_1);

    if (e1_region.style.display == 'none') {
        e1_region.style.display = '';
        e2_region.style.display = 'none';
        e1.innerHTML = e2.value;
        e1.focus();
    }
    else {
        e1_region.style.display = 'none';
        e2_region.style.display = '';
        if (debug == 1) {
            err.innerHTML = "<STRONG>e1</STRONG><br/>ID: " + e1.id + '<br/>Value: ' + e1.value + '<br/>innerHTML: ' + e1.innerHTML + '<br/>'
            err.innerHTML += "<STRONG>e2</STRONG><br/>ID: " + e2.id + '<br/>Value: ' + e2.value + '<br/>innerHTML: ' + e2.innerHTML
        }
        if (bBlank == false) {
            e2.value = e1.innerHTML;
        }
        else {
            e2.value = '';
        }
        e2.focus();
        e2.select();
    }
}

function write_edit(element_id, element_2_id, data_element_id) {
    e1 = document.getElementById(element_id);
    e2 = document.getElementById(element_2_id);
    
    //alert(e1.innerHTML);
    //alert(e2.value);
    
    if(e1.innerHTML != e2.value) {
        busyElement = document.getElementById(e1.id + '_busy');
        oldId = busyElement.id;
        busyElement.id = 'busy';

        busyElement.style.display = '';

        // This is really a fire and forget at the moment. There is no validation that
        // is processed by the server. I think think may have to become a lot more complex
        // (or at least sophisticated) or we should re-consider using Ajax. We are not
        // dealing with massive amounts of data.
        $("#data_sheet_form").submit();
        
//        delay_for_development_environment();
//        busyElement.style.display = 'none';
//        alert(busyElement.id);
        // We have to fade out because simply setting the 'display' to 'none' was too quick
        // and we never got to see our 'busy' icon.
        $('#' + busyElement.id).fadeOut(1000);
        
        busyElement.id = oldId;
    }
    switch_edits(element_id, element_2_id);
}

//$(document).ajaxSuccess(function() {
//    alert('Successful');
//});
$(document).ready(function() {
})


function handle_enter(element_id_1, element_id_2, event) {
    var charCode;
    
    if(event && event .which){
        charCode = event .which;
    }else if(window.event){
        event  = window.event;
        charCode = event .keyCode;
    }

    if(charCode == 13) {
        write_edit(element_id_1, element_id_2);
    }
}

/*
 Ajax.Responders.register({
  onCreate: function() {
    if($('busy') && Ajax.activeRequestCount>0)
      Effect.Appear('busy',{duration:0.5,queue:'end'});
  },
  onComplete: function() {
    if($('busy') && Ajax.activeRequestCount==0)
      Effect.Fade('busy',{duration:0.5,queue:'end'});
  }
});
*/

function toggleExpansion(hidden_id, current_value, div_area) {
    e1 = document.getElementById(hidden_id);
    e1.value = (current_value == 1 ? 0 : 1);
    $("data_sheet_form").request({
        onSuccess: function(response) {eval(response)}
    });
}

function navigate_to_shadow_globe(globe_id)
{
    if (globe_id != 0)
    {
        var answer = confirm("Would you like to navigate to: " + document.location.protocol + '//' + document.location.host + '/globes/' + globe_id + '/preview')
        if (answer)
            window.location = document.location.protocol + '//' + document.location.host + '/globes/' + globe_id + '/preview'
    }
}

function navigate_to_data_sheet(globe_id, profile_id, selector_id)
{
    selector = document.getElementById(selector_id);
    id = selector.options[selector.selectedIndex].value;
    window.location = document.location.protocol + '//' + document.location.host + '/globes/' + globe_id + '/profiles/' + profile_id + '/data_sheets/' + id + '/preview';
}

function subscription_link_profiles_refresh(globe_id)
{
    
}

// Ryan Bates: Nested Forms
function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

// Ryan Bates: Nested Forms
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

function fillPopupBody(popup, partial) {
  var req = new XMLHttpRequest();
  req.open("GET", "/something/_" + partial + ".html.erb", false); // Synchronic request!
  req.send(null);
  if( req.status == 200 ) {
    popup.innerHTML = req.responseText;
    return true;
  } else {
    popup.innerHTML = "<p class='error'>"+req.status+" ("+req.statusText+")</p>";
    return false;
  }
}

