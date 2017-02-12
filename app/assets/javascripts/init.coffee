document.addEventListener "turbolinks:load", ->
  # marked
  $('.markdown').each ->
    $el = $(@)
    $el.html marked($el.html())

  # autosize
  autosize document.querySelectorAll('textarea')
