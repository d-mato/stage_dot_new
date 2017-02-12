document.addEventListener "turbolinks:load", ->
  # marked
  $('.markdown').each ->
    $el = $(@)
    $el.html marked($el.html())

  # autosize
  autosize document.querySelectorAll('textarea')

  # fade out flash messages
  ( ->
    if flash = document.querySelector('#flash_messages')
      setTimeout (-> flash.classList.toggle 'fade'), 3000
  )()
