CKEDITOR.plugins.add( 'carousel', {
  requires: 'widget',
  icons: 'carousel',
  init: function( editor ) {
    editor.widgets.add( 'carousel', {
      button: 'Анонсные блоки',
      template:
          '<div class="carousel-placeholder">' +
              'Анонсные блоки' + 
          '</div>',
      allowedContent: 'div(!carousel-placeholder)',
      requiredContent: 'div(carousel-placeholder)',
      upcast: function( element ) {
        return element.name == 'div' && $(element).hasClass( 'carousel-placeholder' );
      }
    });
  }
});