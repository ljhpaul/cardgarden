$(function () {
  const $stickyMenu = $(".sticky-menu");

  $(window).on("scroll", function () {
    if ($(this).scrollTop() > 235) {
      $stickyMenu.css("visibility", "visible");
    } else {
      $stickyMenu.css("visibility", "hidden");
    }
  });
});
