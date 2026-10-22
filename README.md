# Chosen for rails asset pipeline

[Chosen](https://github.com/JJJ/chosen) is a library for making long, unwieldy select boxes more user friendly. This gem packages the actively maintained `chosen-jjj` fork.

The `chosen-dartsass` gem integrates Chosen into the Rails asset pipeline. It supports either [Propshaft](https://github.com/rails/propshaft) with [dartsass-rails](https://github.com/rails/dartsass-rails), or [Sprockets](https://github.com/rails/sprockets) with [dartsass-sprockets](https://github.com/tablecheck/dartsass-sprockets).

## Usage

### Install chosen-dartsass gem

Include `chosen-dartsass` and one Sass integration in your Gemfile.

For Propshaft:

```rb
gem 'jquery-rails'
gem 'dartsass-rails'
gem 'chosen-dartsass'
```

For Sprockets:

```rb
gem 'jquery-rails'
gem 'dartsass-sprockets'
gem 'chosen-dartsass'
```

Do not install both Sass integrations in the same application.

Then run `bundle install`

### About JQuery

You can get jquery via [jquery-rails](https://github.com/rails/jquery-rails).

Please consider [jquery-turbolinks](https://github.com/kossnocorp/jquery.turbolinks) if you have turbolinks issues for Rails 4 +.

### Include chosen javascript assets

Add to your `app/assets/javascripts/application.js` if use with jQuery

```javascript
//= require jquery
//= require chosen-jquery
```

### Include chosen stylesheet assets

With `dartsass-rails`, add this to `app/assets/stylesheets/application.scss`:

```scss
@use "chosen";
```

With `dartsass-sprockets`, add this to the manifest comment in `app/assets/stylesheets/application.css` or `application.scss`:

```scss
 *= require chosen
```

### Enable chosen javascript by specific css class

For rails 6, remember to add `javascript_include_tag` in `app/views/layouts/application.html.erb`, like

```ruby
<%= javascript_include_tag 'application' %>
```

Add to one javascript file, like `scaffold.js`

```js
$(function() {
  // enable chosen js
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '200px'
  });
});
```

Notice: `width` option is required since `Chosen 0.9.15`.

And this file must be included in `application.js`

```javascript
//= require chosen-jquery
//= require scaffold
```

Also add the class to your form field

```erb
<%= f.select :author,
  User.all.map { |u| [u.name, u.id] },
               { include_blank: true },
               { class: 'chosen-select' }
%>
```

If you use simple form as form builder

```erb
<%= f.association :author,
                  collection: User.all,
                  include_blank: true,
                  input_html: { class: 'chosen-select' }
%>
```

### Deployment

Since version 0.13.0, non-digested assets of `chosen-dartsass` will simply be copied from digested assets.

## RSpec helpers
`chosen-dartsass` provides RSpec feature helper methods that allow users to select or unselect options from both single and multiple chosen elements. Add the following to your `spec/rails_helper.rb` (or `spec/spec_helper.rb`):

```ruby
require 'chosen-dartsass/rspec'
```

This automatically configures RSpec by adding:

```ruby
RSpec.configure do |config|
  config.include Chosen::Rspec::FeatureHelpers, type: :feature
end
```

Configuration includes two additional methods for all `type: :feature` specs:

```ruby
chosen_select(value, options = {})
chosen_unselect(value, options = {})
```

Both methods require `from: '...'` inside the `options` hash that is either a CSS selector or a field's label (requires the `for` attribute on the label!).

### Example usage
To handle a single select:

```ruby
chosen_select('Leo Tolstoy', from: 'Author')
chosen_unselect('Leo Tolstoy', from: '#author')
chosen_select('Fyodor Dostoyevsky', from: '#author')
```

To handle a multiple select:

```ruby
chosen_select('Leo Tolstoy', 'Fyodor Dostoyevsky', 'Anton Chekhov', from: 'Authors')
# or, by single value:
chosen_select('Leo Tolstoy', from: '#authors')

chosen_unselect('Fyodor Dostoyevsky', ' Anton Chekhov', from: 'Authors')
# or, by single value:
chosen_unselect('Leo Tolstoy', from: '#authors')
```

## Gem maintenance

Maintain `chosen-dartsass` gem with `Rake` commands.

Update the chosen-jjj source files.

```bash
rake update-chosen
```

Publish gem.

```bash
rake release
```

## License

use MIT license.
