document.addEventListener "DOMContentLoaded", ->
  return false unless document.querySelector('form')

  # Markdown preview
  document.querySelectorAll('textarea').forEach (textarea) ->
    preview = document.querySelector(".preview[data-target='##{textarea.id}']")
    return true unless preview

    preview.innerHTML = marked(textarea.value)
    textarea.addEventListener 'keyup', ->
      preview.innerHTML = marked(textarea.value)


  # フォームの入力値が変更されていたらページ離脱時に確認ダイアログ表示
  ( ->
    unsaved = false
    document.querySelector('form').addEventListener 'submit', (e) ->
      unsaved = false
    window.addEventListener 'beforeunload', (e) ->
      e.returnValue = "変更が保存されない可能性があります。" if unsaved

    document.querySelectorAll('textarea, input').forEach (el) ->
      default_value = el.value
      el.addEventListener 'change', (e) ->
        new_value = e.target.value
        unsaved = (new_value != default_value)
  )()
