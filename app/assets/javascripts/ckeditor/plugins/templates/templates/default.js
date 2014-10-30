/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

// Register a templates definition set named "default".
CKEDITOR.addTemplates( 'default', {

	imagesPath: CKEDITOR.getUrl( CKEDITOR.plugins.getPath( 'templates' ) + 'templates/images/' ),

	// The templates definitions.
	templates: [
		{
			title: 'Блок с текстом',
			description: 'Блок с текстом на странице.',
			html: '<div class="paragraphs"><p>Текст блока</p></div>'
		},
		{
			title: 'Выделенный блок с текстом',
			description: 'Выделенный блок с текстом на странице.',
			html: '<div class="paragraphs-green"><p>Текст выделенного блока</p></div>'
		},
		{
			title: 'Обычная таблица',
			description: 'Единственная таблица с полями на странице.',
			html: "<table>" +
				"<tr>" +
					"<td>Поле 1</td>" +
					"<td>Значение 1</td>" +
				"</tr>" +
				"<tr>" +
					"<td>Поле 2</td>" +
					"<td>Значение 2</td>" +
				"</tr>" +
				"<tr>" +
					"<td>Поле 3</td>" +
					"<td>Значение 3</td>" +
				"</tr>" +
			"</table>"
		},
		{
			title: 'Выделенная таблица',
			description: 'Выделенная и обычная таблица с полями на странице.',
			html: "<table class='green'>" +
				"<tr>" +
					"<td>Поле 1</td>" +
					"<td>Значение 1</td>" +
				"</tr>" +
				"<tr>" +
					"<td>Поле 2</td>" +
					"<td>Значение 2</td>" +
				"</tr>" +
				"<tr>" +
					"<td>Поле 3</td>" +
					"<td>Значение 3</td>" +
				"</tr>" +
			"</table>"
		},
		{
			title: 'Закладки',
			description: 'Выделенная и обычная таблица с полями на странице.',
			html: "<h3>Заголовок</h3>" +
				"<div class='tabs'>" +
					"<div class='buttons'>" +
						"<a href=''>Закладка 1</a>" +
						"<a href=''>Закладка 2</a>" +
					"</div>" +
					"<div class='pages'>" +
						"<div class='page'>" +
							"<p>Содержание закладки 1</p>" +
						"</div>" +
						"<div class='page'>" +
							"<p>Содержание закладки 2</p>" +
						"</div>" +
					"</div>" +
				"</div>"
		}
	]
});
