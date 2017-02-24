EventColor = {
  'カジュアル面談': '#5CB85C'
  '懇親会': '#5CB85C'
  '面接': '#DF691A'
}

document.addEventListener "turbolinks:load", ->
  return unless document.querySelector('#calendar')

  # .htmlで中身を空にしないとturbolinks環境でページを戻る度にカレンダーが増えていく
  $('#calendar').html('').fullCalendar
    timeFormat: 'H:mm'

  $.get '/interviews.json', (json) ->
    events = json.map (interview) ->
      title: interview.company
      start: interview.start_at
      url: "/interviews/#{interview.id}"
      color: EventColor[interview.category]

    # TIPS: 第3引数にtrueを与えることで登録されたイベントが永続的になり
    # 月を移動してもリセットされなくなる
    $('#calendar').fullCalendar 'renderEvents', events, true
