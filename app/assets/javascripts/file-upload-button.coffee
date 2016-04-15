$(document).on 'ready page:load', ->
  inputs = document.querySelectorAll('.file-upload')
  Array::forEach.call inputs, (input) ->
    label = input.nextElementSibling
    labelVal = label.innerHTML

    input.addEventListener 'change', (e) ->
      fileName = ''
      fileName = e.target.value.split('\\').pop()
      if fileName
        label.querySelector('strong').innerHTML = fileName
      else
        label.innerHTML = labelVal

    # Firefox bug fix
    input.addEventListener 'focus', ->
      input.classList.add 'has-focus'
    input.addEventListener 'blur', ->
      input.classList.remove 'has-focus'