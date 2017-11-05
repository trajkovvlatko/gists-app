// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"


var fields = document.querySelectorAll("textarea");
if (fields.length > 0) {
  for (var i = 0; i < fields.length; i++) {
    var field = fields[i];
    var codeMirrorOptions = {
      lineNumbers: true,
      tabSize: 2,
    }
    if (field.className.indexOf("readonly") > -1) {
      codeMirrorOptions.readOnly = true;
    }
    CodeMirror.fromTextArea(field, codeMirrorOptions);
  }
}

var searchField = document.querySelector(".search-field");
searchField.onkeyup = function(e) {
  var code = (e.keyCode ? e.keyCode : e.which);
  if (code !== 13) {
    return false;
  }

  var searchTerm = searchField.value;
  searchTerm = searchTerm ? searchTerm.trim() : "";
  if (searchTerm === "") {
    return false;
  }

  window.location = "/search/" + searchTerm;
}
