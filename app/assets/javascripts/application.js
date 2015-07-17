// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require event

var _rm_event = {
  name: "new name",
}

var _rm_request = new XMLHttpRequest();
_rm_request.open("POST", "http://localhost:3000/api/events", true);
_rm_request.setRequestHeader('Content-Type', 'application/json');
_rm_request.onreadystatechange = function() {
};


_rm_request.send(JSON.stringify(_rm_event));