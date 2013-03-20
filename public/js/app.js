// Generated by CoffeeScript 1.6.2
(function() {
  $(function() {
    $("#load_button").on("click", function() {
      return $("#load").click();
    });
    $("#load").on("change", function() {
      var name, reader, selected_file;

      selected_file = $("#load").get(0).files[0];
      name = selected_file.name;
      reader = new FileReader();
      reader.onload = function(event) {
        return $("#xml").val(event.target.result);
      };
      if (name.match(/\.xml$/)) {
        reader.readAsText(selected_file);
      } else {
        alert("Bad file extension. Please use .xml");
      }
      return $("#load").val("");
    });
    return $("#blog_info").submit(function() {
      $("#submit").text("working...");
      return $("#submit").attr("disabled", "disabled");
    });
  });

}).call(this);