$(function () {
  const $stickyMenu = $(".sticky-menu");

  $(window).on("scroll", function () {
    if ($(this).scrollTop() > 185) {
      $stickyMenu.css("visibility", "visible");
    } else {
      $stickyMenu.css("visibility", "hidden");
    }
  });
});