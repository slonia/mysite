//= require jquery
//= require jquery_ujs
//= require jquery-ui/sortable
//= require jquery_nested_form
//= require turbolinks
//= require bootstrap
//= require selectize
//= require groups

function start() {
  $('.custom_select').selectize()

}
$(document).ready(start)
$(document).on('page:load', start)
