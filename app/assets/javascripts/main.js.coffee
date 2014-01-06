# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

moderate_error = () ->
  $('#moderate-alert-container').html("""
          <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    				<p>There was an error performing that action. Please try again later.</p>
    			</div>
        """)
  $.scrollTo('#moderate-alert-container')

moderate_success = (user_id, data) ->
  $('#moderate-alert-container').html("""
    <div class="alert alert-info alert-dismissable">
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
      <p>#{ data.msg }</p>
    </div>
  """)
  $.scrollTo('#moderate-alert-container')
  $('#user-'+user_id).fadeOut()

init = () ->
  $('.moderate-reject').click () ->
    user_id = $(this).attr('data-user-id')
    $('#' + user_id + '-approve').hide()
    $('#' + user_id + '-reject').show()

  $('.moderate-approve').click () ->
    user_id = $(this).attr('data-user-id')
    $('#' + user_id + '-reject').hide()
    $('#' + user_id + '-approve').show()

  $('.btn-submit-reject').click () ->
    user_id = $(this).attr('data-user-id')
    $.ajax '/users/' + user_id + '/reject',
      type: 'POST'
      data: { rejection: $('#'+user_id+'-reject-input').val() }
      error: moderate_error
      success: moderate_success.bind(undefined, user_id)

  $('.btn-submit-approve').click () ->
    user_id = $(this).attr('data-user-id')
    $.ajax '/users/' + user_id + '/approve',
      type: 'POST'
      data: { approval: $('#'+user_id+'-approve-input').val() }
      error: moderate_error,
      success: moderate_success.bind(undefined, user_id)

                        
$(document).on "page:change", ->
  init()

