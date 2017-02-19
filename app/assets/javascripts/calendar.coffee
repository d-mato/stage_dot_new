document.addEventListener "turbolinks:load", ->
  if document.querySelector('#calendar')
    $('#calendar').fullCalendar()
