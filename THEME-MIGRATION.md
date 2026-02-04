# Minimal Mistakes Theme Migration

This site has been migrated to the Minimal Mistakes Jekyll theme.

## Changes Made

### Removed Files (old Jekyll Now theme files)
The following directories and files were removed because Minimal Mistakes provides them through the remote theme:
- `_layouts/` - Old custom layouts (default.html, page.html, post.html)
- `_includes/` - Old custom includes (analytics.html, disqus.html, meta.html, svg-icons.html)
- `_sass/` - Old custom SASS files (_highlights.scss, _reset.scss, _svg-icons.scss, _variables.scss)
- `style.scss` - Old custom stylesheet

### Updated Files
- `Gemfile` - Updated for Minimal Mistakes theme dependencies
- `_config.yml` - Already configured for Minimal Mistakes
- `_data/navigation.yml` - Navigation structure compatible with Minimal Mistakes

### What Minimal Mistakes Provides
- Modern responsive design
- Built-in layouts: default, single, archive, home, posts, categories, tags, collection, search, splash
- SEO optimization
- Social media integration
- Author profiles
- Analytics support
- Comments support (Disqus, Discourse, Facebook, etc.)
- Search functionality
- Multiple skins/themes

## Documentation
- [Minimal Mistakes Quick-Start Guide](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/)
- [Configuration Documentation](https://mmistakes.github.io/minimal-mistakes/docs/configuration/)
- [Layouts Documentation](https://mmistakes.github.io/minimal-mistakes/docs/layouts/)

## Next Steps
1. Run `bundle install` to install dependencies
2. Run `bundle exec jekyll serve` to test locally
3. Review and customize the skin in `_config.yml` (minimal_mistakes_skin setting)
4. Add custom CSS overrides in `assets/css/main.scss` if needed
