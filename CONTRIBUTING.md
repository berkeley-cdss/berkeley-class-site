# Contributing

TODO write docs for staff here

## Liquid Tags

[Liquid](https://shopify.github.io/liquid/) is a template language. Liquid tags look like `{% tag_name ... %}` and you can read more about how they work with Jekyll [here](https://jekyllrb.com/docs/liquid/).

Some tags you may find useful:

- [`{% link <path> %}`](https://jekyllrb.com/docs/liquid/tags/#links)

## Continuous Integration (GitHub Actions)

TODO Info here about workflows and links

Most of the linters in `.github/workflows/linters.yml` are powered by [reviewdog](https://github.com/reviewdog/reviewdog).

Run `bundle exec rubocop` to run [Rubocop](https://rubocop.org/). To autocorrect certain errors, run `bundle exec rubocop --autocorrect`.

## Testing

To run tests, run `bundle exec rspec`

## Resources

- [Jekyll](https://jekyllrb.com/)
- [GitHub](https://docs.github.com/)
