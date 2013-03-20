$ ->
  $("#load_button").on "click", -> $("#load").click()
  $("#load").on "change", ->
    selected_file = $("#load").get(0).files[0]
    name = selected_file.name
    reader = new FileReader()
    reader.onload = (event) -> $("#xml").val(event.target.result)
    if name.match /\.xml$/
      reader.readAsText selected_file
    else
      alert "Bad file extension. Please use .xml"
    $("#load").val "" # unloading the file from the file input
  $("#blog_info").submit ->
    $("#submit").text "working..."
    $("#submit").attr "disabled", "disabled"
