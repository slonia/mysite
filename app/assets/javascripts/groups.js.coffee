updateSelect = (el) ->
  teachers_sel = $(el).next('.teacher-select')
  $.getJSON "/api/subjects/" + $(el).children(':selected').val() + '/teachers', (teachers) ->
    teachers_sel.empty()
    teachers_sel.append('<option></option>')
    for teacher,i in teachers
      if i==0
        teachers_sel.append('<option selected="true" value=' + teacher.id + '>' + teacher.short_name + "</option>")
      else
        teachers_sel.append('<option value=' + teacher.id + '>' + teacher.short_name + "</option>")

add_sec = (el) ->
  first = $(el).parents('.fields:first')
  if first.next('.fields').find("input[id$='second_group']").is(':checked')
    second = first.next('.fields')
    first.hide()
    second.show()
  else
    link = first.parents('.day-wrapper').find('.second-link')
    ind = first.parents('.day-wrapper').find('.fields').index(first)
    link.data('index', ind)
    link.click()

hide_second = () ->
  $('.lesson-card').each ->
    if $(@).find("input[id$='second_group']").is(':checked')
      $(@).parent('.fields').hide()
ready = ->
  $('#all_days').sortable
    items: '.day-wrapper > .fields'
    cursor: 'move'
    tolerance: 'pointer'
    revert: true
    update: (event, ui)->
      obj = ui.item
      matcher = obj.find('.lesson-card').attr('id').match(/(.*_\d*)(a|b)/)
      if matcher
        id = '#' + matcher[1]
        if matcher[2] == 'a'
          id += 'b'
          $(id).parent('.fields').insertAfter(obj)
        else
          id += 'a'
          $(id).parent('.fields').insertBefore(obj)

  $('.subject-select').change ->
    updateSelect($(@))
  # $('.subject-select').selectize()
  # $('.room-select').selectize()
  $('.add-second').click (e) ->
    console.log('aa')
    e.preventDefault()
    add_sec($(@))
  hide_second()

  $("input[id$='blank']").on 'change', ->
    card = $(@).parents('.lesson-card')
    card.find(':input').attr('disabled', $(@).is(':checked'))
    card.find('.selectize-control').each ->
      $(@).children('.selectize-input').toggleClass('disabled')
    $(@).attr('disabled', false)

  $('.group-form').submit ->
    $(@).find('.day-wrapper').each ->
      day = $(@).data('id')
      ind = 0
      seconds = 0
      cards = $(@).find("input[id$='destroy']").parents('.lesson-card').parent('.fields')
      cards_num = cards.length
      $(cards).find(':input').removeAttr('disabled');
      while ind < cards_num
        el = cards[ind]
        if $(el).find("input[id$='destroy']").val() == 'false'
          num = $(el).find("input[id$='number']")
          val = ind - seconds
          num.val(val)
          if ind + 1 < cards_num && $(cards[ind+1]).find("input[id$='second_group']").is(':checked')
            $(cards[ind+1]).find("input[id$='number']").val(val)
            if !!$(cards[ind+1]).find("input[id$='day_id']")
              $(cards[ind+1]).find("input[id$='day_id']").val(day)
            ind += 1
            seconds += 1
          if !!$(el).find("input[id$='day_id']")
            $(el).find("input[id$='day_id']").val(day)
          ind += 1
        else
          ind += 1
    true
$(document).on 'nested:fieldAdded:lessons', (e)->
  updateSelect(e.field.find('.subject-select'))
  # e.field.find('.subject-select').selectize()
  # e.field.find('.room-select').selectize()
  e.field.find('.subject-select').change ->
    updateSelect($(@))
  if $(e.link).data('second')
    e.field.find('.second-group').attr('checked', true)
    second = e.field
    first = second.parents('.day-wrapper').children('.fields').eq($(e.link).data('index'))
    second.insertAfter(first)
    link = second.find('.add-second')
    link.text('1я группа')
    link.removeClass('add-second').addClass('return-first btn-warning')
    newid = first.find('.lesson-card').attr('id').replace(/(.*_\d*)(a)/, "$1b")
    second.find('.lesson-card').attr('id', newid)
    first.hide()
  e.field.find('.add-second').click (e) ->
    e.preventDefault()
    add_sec($(@))
  e.field.find("input[id$='blank']").on 'change', ->
    $(@).parents('.lesson-card').find(':input').attr('disabled', $(@).is(':checked'))
    $(@).attr('disabled', false)

$(document).ready(ready)
$(document).on('page:load', ready)

$(document).on 'click', '.return-first', (e) ->
  e.preventDefault()
  second = $(@).parents('.fields:first')
  first = second.prev('.fields')
  second.hide()
  first.show()
