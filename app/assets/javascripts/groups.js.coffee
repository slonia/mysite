updateSelect = (el) ->
  teachers_sel = $(el).next('.teacher-select')
  $.getJSON "/api/subjects/" + $(el).children(':selected').val() + '/teachers', (teachers) ->
    teachers_sel.empty()
    for teacher in teachers
      teachers_sel.append('<option value=' + teacher.id + '>' + teacher.name + "</option>")

ready = ->
  $('#all_days').sortable
    items: '.day-wrapper > .fields'
    cursor: 'move'
    tolerance: 'pointer'
  $('.subject-select').change ->
    updateSelect($(@))

  $("input[id$='blank']").on 'change', ->
    console.log('chech')
    $(@).parents('.lesson-card').find(':input').attr('disabled', $(@).is(':checked'))
    $(@).attr('disabled', false)

  $('.group-form').submit ->
    $(@).find('.day-wrapper').each ->
      day = $(@).data('id')
      ind = 0
      $(@).find('.lesson-card').each (index, el)->
        if $(@).parent('.fields').is(':visible')
          $(@).children("input[id$='day_id']").val(day)
          $(@).children("input[id$='number']").val(ind)
          ind += 1
    true
$(document).on 'nested:fieldAdded:lessons', (e)->
  updateSelect(e.field.find('.subject-select'))
  e.field.find("input[id$='blank']").on 'change', ->
    console.log('chech')
    $(@).parents('.lesson-card').find(':input').attr('disabled', $(@).is(':checked'))
    $(@).attr('disabled', false)

$(document).ready(ready)
$(document).on('page:load', ready)


