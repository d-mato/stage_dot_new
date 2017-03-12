document.addEventListener "DOMContentLoaded", ->
  # Markdown preview
  document.querySelectorAll('textarea').forEach (textarea) ->
    preview = document.querySelector(".preview[data-target='##{textarea.id}']")
    return true unless preview

    preview.innerHTML = marked(textarea.value)
    textarea.addEventListener 'keyup', ->
      preview.innerHTML = marked(textarea.value)
