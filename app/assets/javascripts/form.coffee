document.addEventListener "turbolinks:load", ->
  $('textarea').each ->
    $textarea = $(@)
    $preview = $(".preview[data-target='##{$textarea.attr('id')}']")
    return true if $preview.length == 0

    $preview.html marked($textarea.val())
    $textarea.on 'keyup', ->
      $preview.html marked($textarea.val())
