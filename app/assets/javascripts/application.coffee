#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require bootstrap-notify
#= require_tree .

jQuery(document).on 'ready page:load', ->
  $('div.card-likes:has(a)').addClass 'has-likes'
