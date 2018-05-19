//= require ./lib/_energize
//= require ./app/_toc
//= require ./app/_lang

$(function() {
  loadToc($('#toc'), '.toc-link', '.toc-list-h2', 10);
  setupLanguages($('body').data('languages'));
  $('.content').imagesLoaded( function() {
    window.recacheHeights();
    window.refreshToc();
  });
});

window.onpopstate = function() {
  activateLanguage(getLanguageFromQueryString());
};

$(function() {
  $(".content pre > code").each(function () {
    $this = $(this);
  
    if (this.offsetHeight < this.scrollHeight) {
      $this.parent().addClass("fold");
    }
  });

  $(".fold").click(function() {
    $(this).addClass("unfolded");
  });
});
