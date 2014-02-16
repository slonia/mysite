updateSelect = (el) ->
  teachers_sel = $(el).next('.teacher-select')
  $.getJSON "/api/subjects/" + $(el).children(':selected').val() + '/teachers', (teachers) ->
    teachers_sel.empty()
    for teacher in teachers
      teachers_sel.append('<option value=' + teacher.id + '>' + teacher.name + "</option>")

add_sec = (el) ->
  first = $(el).parent('.lesson-card').parent('.fields')
  if first.next('.fields').find("input[id$='second_group']").is(':checked')
    second = first.next('.fields')
    first.hide()
    second.show()
  else
    link = first.parents('.day-wrapper').find('.second-link')
    ind = first.parents('.day-wrapper').find('.add-second').index($(el))
    link.data('index', ind)
    link.click()

hide_second = () ->
  $('.lesson-card').children('.return-first').each ->
    $(@).parent('.lesson-card').parent('.fields').hide()
ready = ->
  $('#all_days').sortable
    items: '.day-wrapper > .fields'
    cursor: 'move'
    tolerance: 'pointer'
  $('.subject-select').change ->
    updateSelect($(@))
  $('.subject-select').selectize()
  $('.room-select').selectize()
  $('.add-second').click (e) ->
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
      $(@).find("input[id$='destroy']").each ->
        if $(@).val() == 'false'
          el = $(@).parents('.lesson-card')
          num = el.find("input[id$='number']")
          if el.find("input[id$='second_group']").is(':checked')
            num.val(ind-1)
            seconds += 1
          else
            num.val(ind)
          ind += 1
          ind -= seconds
    true
$(document).on 'nested:fieldAdded:lessons', (e)->
  updateSelect(e.field.find('.subject-select'))
  e.field.find('.subject-select').selectize()
  e.field.find('.room-select').selectize()
  if $(e.link).data('second')
    e.field.find('.second-group').attr('checked', true)
    second = e.field
    first = second.parent('.day-wrapper').children('.fields').eq($(e.link).data('index'))
    second.insertAfter(first)
    link = second.find('.add-second')
    link.text('first')
    link.removeClass('add-second').addClass('return-first')
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
  second = $(@).parent('.lesson-card').parent('.fields')
  first = second.prev('.fields')
  second.hide()
  first.show()
