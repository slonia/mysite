updateSelect = (el) ->
  teachers_sel = $(el).next('.teacher-select')
  $.getJSON "/api/subjects/" + $(el).children(':selected').val() + '/teachers', (teachers) ->
    teachers_sel.empty()
    for teacher in teachers
      teachers_sel.append('<option value=' + teacher.id + '>' + teacher.name + "</option>")

add_sec = (el) ->
  link = $(el).parents('.day-wrapper').find('.second-link')
  ind = $(el).parents('.day-wrapper').find('.add-second').index($(el))
  link.data('index', ind)
  link.click()

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
      $(@).children('.fields').children('.lesson-card').each ->
        if $(@).parent('.fields').is(':visible')
          $(@).children("input[id$='day_id']").val(day)
          $(@).children("input[id$='number']").val(ind)
          $(@).siblings('.fields').find("input[id$='day_id']").val(day)
          $(@).siblings('.fields').find("input[id$='number']").val(ind)
          ind += 1
    true
$(document).on 'nested:fieldAdded:lessons', (e)->
  updateSelect(e.field.find('.subject-select'))
  e.field.find('.subject-select').selectize()
  e.field.find('.room-select').selectize()
  if $(e.link).data('second')
    e.field.find('.second-group').attr('checked', true)
    el = e.field
    # debugger
    el.appendTo(el.parents('.day-wrapper').children('.fields').eq($(e.link).data('index')))
  e.field.find('.add-second').click (e) ->
    e.preventDefault()
    add_sec($(@))
  e.field.find("input[id$='blank']").on 'change', ->
    $(@).parents('.lesson-card').find(':input').attr('disabled', $(@).is(':checked'))
    $(@).attr('disabled', false)

$(document).ready(ready)
$(document).on('page:load', ready)


