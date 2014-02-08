$(document).ready ->
  $('#all_days').sortable
    items: '.lesson-card'

  $('.subject-select').change ->
    teachers_sel = $(@).next('.teacher-select')
    $.getJSON "/api/subjects/" + $(@).children(':selected').val() + '/teachers', (teachers) ->
      teachers_sel.empty()
      for teacher in teachers
        teachers_sel.append('<option value=' + teacher.id + '>' + teacher.name + "</option>")

  $('.subject-select').change()
