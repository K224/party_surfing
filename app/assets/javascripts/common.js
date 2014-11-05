function initNicEditor(textareaName)
{
  $(document).on('page:load', function(){
    window['rangy'].initialized = false;
  })
  var script = document.createElement('script');
  script.src = "/nicedit/nicEdit.js";
  document.documentElement.appendChild(script);

  script.onload = function() {
    new nicEditor().panelInstance(textareaName);
  }
}

