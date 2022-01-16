;(function () {
  document.addEventListener('DOMContentLoaded', function () {
    if (!document.querySelector('form')) {
      return false
    }

    // Markdown preview
    document.querySelectorAll('textarea').forEach(function (textarea) {
      const preview = document.querySelector(".preview[data-target='#" + textarea.id + "']")
      if (!preview) {
        return true
      }
      preview.innerHTML = marked(textarea.value)
      return textarea.addEventListener('keyup', function () {
        return (preview.innerHTML = marked(textarea.value))
      })
    })

    // フォームの入力値が変更されていたらページ離脱時に確認ダイアログ表示
    let unsaved = false
    document.querySelector('form').addEventListener('submit', function (e) {
      unsaved = false
    })
    window.addEventListener('beforeunload', function (e) {
      if (unsaved) {
        e.returnValue = '変更が保存されない可能性があります。'
      }
    })
    document.querySelectorAll('textarea, input').forEach(function (el) {
      let default_value = el.value
      el.addEventListener('change', function (e) {
        const new_value = e.target.value
        unsaved = new_value !== default_value
      })
    })
  })
}.call(this))
