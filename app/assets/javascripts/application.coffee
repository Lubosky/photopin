#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require bootstrap-notify
#= require_tree .

$(document).on 'ready page:load', ->
  $('div.card-likes:has(a)').addClass 'has-likes'

filePreview = (input) ->
  if input.files and input.files[0]
    reader = new FileReader
    reader.onload = (e) ->
      $('#preview_img').attr 'src', e.target.result
    reader.readAsDataURL input.files[0]

$(document).on 'change', 'input#previewable', ->
  filePreview this
