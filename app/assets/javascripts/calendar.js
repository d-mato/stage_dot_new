;(function () {
  const EventColor = {
    カジュアル面談: '#5CB85C',
    懇親会: '#5CB85C',
    面接: '#DF691A'
  }

  document.addEventListener('DOMContentLoaded', function () {
    const calendarContainer = document.querySelector('#calendar')
    if (!calendarContainer) {
      return false
    }

    // .htmlで中身を空にしないとturbolinks環境でページを戻る度にカレンダーが増えていく
    $('#calendar').html('').fullCalendar({
      timeFormat: 'H:mm'
    })

    $.get('/interviews.json', function (json) {
      const events = json.map(function (interview) {
        return {
          title: interview.company,
          start: interview.start_at,
          url: '/interviews/' + interview.id,
          color: EventColor[interview.category]
        }
      })

      // TIPS: 第3引数にtrueを与えることで登録されたイベントが永続的になり
      // 月を移動してもリセットされなくなる
      $('#calendar').fullCalendar('renderEvents', events, true)
    })
  })
}.call(this))
