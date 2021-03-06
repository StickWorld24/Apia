/**
 * Autocompleter.Request
 *
 * http://digitarald.de/project/autocompleter/
 *
 * @version		1.1.2
 *
 * @license		MIT-style license
 * @author		Harald Kirschner <mail [at] digitarald.de>
 * @copyright	Author
 */

Autocompleter.Request = new Class({

	Extends: Autocompleter,

	options: {/*
		indicator: null,
		indicatorClass: null,
		onRequest: $empty,
		onComplete: $empty,*/
		postData: {},
		dynamicData: {},
		ajaxOptions: {},
		postVar: 'value'

	},

	query: function(){
		var data = $unlink(this.options.postData) || {};
		var dynamicData = $unlink(this.options.dynamicData) || {};
		$each(dynamicData, function(id, index) {
			data[index] = $(id).get('value');
		});
		
		var realValue = this.queryValue;
		var indexCreate = !realValue? -1 : realValue.indexOf(" (crear al confirmar)");
		if (indexCreate != -1) {
			var createLength = " (crear al confirmar)".length;
			var partA = realValue.substring(0, indexCreate);
			var partB = (indexCreate + createLength + 1 < realValue.length) ? realValue.substring(indexCreate + createLength) : "";
			
			realValue = partA + partB;
		}
		
		data[this.options.postVar] = realValue;
		var indicator = $(this.options.indicator);
		if (indicator) indicator.setStyle('display', '');
		var cls = this.options.indicatorClass;
		if (cls) this.element.addClass(cls);
		this.fireEvent('onRequest', [this.element, this.request, data, this.queryValue]);
		this.request.send({'data': data});
	},

	/**
	 * queryResponse - abstract
	 *
	 * Inherated classes have to extend this function and use this.parent()
	 */
	queryResponse: function() {
		var indicator = $(this.options.indicator);
		if (indicator) indicator.setStyle('display', 'none');
		var cls = this.options.indicatorClass;
		if (cls) this.element.removeClass(cls);
		return this.fireEvent('onComplete', [this.element, this.request]);
	}

});

Autocompleter.Request.JSON = new Class({

	Extends: Autocompleter.Request,

	initialize: function(el, url, options) {
		this.parent(el, options);
		this.request = new Request.JSON($merge({
			'url': url,
			'link': 'cancel'
		}, this.options.ajaxOptions)).addEvent('onComplete', this.queryResponse.bind(this));
	},

	queryResponse: function(response) {
		this.parent();
		this.update(response);
	}

});

Autocompleter.Request.HTML = new Class({

	Extends: Autocompleter.Request,

	initialize: function(el, url, options) {
		this.parent(el, options);
		this.request = new Request.HTML($merge({
			'url': url,
			'link': 'cancel',
			'update': this.choices
		}, this.options.ajaxOptions)).addEvent('onComplete', this.queryResponse.bind(this));
	},

	queryResponse: function(tree, elements) {
		this.parent();
		if (!elements || !elements.length) {
			//this.hideChoices();
			(this.options.emptyChoices || this.hideChoices).call(this);
		} else {
			this.choices.getChildren(this.options.choicesMatch).each(this.options.injectChoice || function(choice) {
				var value = choice.innerHTML;
				choice.inputValue = value;
				this.addChoiceEvents(choice.set('html', this.markQueryValue(value)));
			}, this);
			this.showChoices();
		}

	}

});

/* compatibility */

Autocompleter.Ajax = {
	Base: Autocompleter.Request,
	Json: Autocompleter.Request.JSON,
	Xhtml: Autocompleter.Request.HTML
};
