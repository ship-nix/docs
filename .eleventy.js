const eleventyNavigationPlugin = require("@11ty/eleventy-navigation");
const pluginTOC = require("eleventy-plugin-nesting-toc");
const pluginSyntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");

const markdownIt = require("markdown-it");
const markdownItAnchor = require("markdown-it-anchor");

module.exports = (eleventyConfig) => {
  eleventyConfig.addPlugin(pluginTOC);
  eleventyConfig.addPlugin(eleventyNavigationPlugin);
  eleventyConfig.addPlugin(pluginSyntaxHighlight);

  eleventyConfig.setLibrary(
    "md",
    markdownIt({
      html: true,
      linkify: true,
      typographer: true,
      breaks: true,
      linkify: true,
    }).use(markdownItAnchor, {})
  );
  return {
    dir: {
      input: "src",
      output: "dist",
    },
  };
};
