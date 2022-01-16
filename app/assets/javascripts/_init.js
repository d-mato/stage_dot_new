;(function () {
  marked.setOptions({
    breaks: true
  })

  document.addEventListener('DOMContentLoaded', function () {
    // marked
    document.querySelectorAll('.markdown').forEach(function (el) {
      el.innerHTML = marked(el.innerHTML.replace(/&gt;/g, '>'))
    })
    // autosize
    autosize(document.querySelectorAll('textarea'))

    // fade out flash messages
    const flash = document.querySelector('#flash_messages')
    if (flash) {
      setTimeout(function () {
        flash.classList.toggle('fade')
      }, 5000)
    }

    $('[data-toggle="tooltip"]').tooltip()
  })
}.call(this))
