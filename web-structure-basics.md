---
title: The Basic Structure of a Webpage
description: You can't scrape what you don't understand
layout: default
---
* We talk about when scraping when we retrieve structured information from content on a website
* One example many of you will know is Zotero, which scrapes information from website into bibliographic metadata
* Web scraping is effective when we have
   * A large amount of information
   * Presented in the same structure on a page or across multiple pages
   * And we're interested in retrieving that information
* This is distinct from "web crawling", where we try to download a large number of whole webpages. R can be used for that, too, using a different package.

## Our Example
* We will work on scraping some basic information for all Assembly Members of the New York State Assembly: [https://nyassembly.gov/mem/](https://nyassembly.gov/mem/)

## The Structure of the Web
* A webpage is made up out of a number elements, called "nodes," that hold its content. Every node begins with a `<>` and ends with a `</>` tag. Nodes are nested in each other.

Here's how a *very* simple web page may look like

```
<html>
  <head>
    <title>Website Title</title>
  </head>
  <body>
    <h1>Headline</h1>
    <div>Some text</div>
    <div>More text</div>
  </body>
</html>
```

* You'll see, above some elements that will occur in virtually every webpage:
  * The `head` is not visible in the browser window, but often contains metadata, including the "title" that's displayed in your open browser tab
  * Elements like `h1` which are headings. There should only be one `h1` element, but there can be multiple `h2`, `h3`, etc.
  * Elements like `div`, `span`, and `p` which structure how text and images are displayed on the page.
* Modern website, however, have one more feature, however, that adds to their structure. Every element can have one or more "attributes" that are included in the beginning tag of the node like so:

```
<div class="article-text">Some text</div>
<div class="article-comment">Some comment</div>
```

* Attributes can be any string, but there are two attributes that are particularly common and well defined: "class" and "id".
* The main difference between the two to keep in mind is that the same `class` can occur multiple times on a single webpage. `class` is often used to mean that this is content of a certain type, e.g. part of the text of the main article, e.g.

```
<div class="article-text">Some text</div>
<div class="article-text">Some more text</div>
```

* On the other hand, in an every decently well written webpage, every `id` should only occur one. `id` is used to label specific content, e.g.

```
<div id="abstract">Abstract for the text</div>
<div id="text-body">The body of the article</div>
<div description="special-content">This is somehow special</div>
```

### Looking at Webpage Structure
You can look at how an element of a webpage is represented in the html code by using the "Inspect" function of your browser. Go ahead and try this right now!

## Selecting Nodes: Cascading Stylesheets (CSS)

* What makes scraping modern webpages easy is that their look is determined by "Cascading Stylesheets" -- CSS. How a node on a webpage is displayed depends on its tag and its attribute.
* We can take advantage of the language used to match these elements to scrape from websites. This language is called "CSS selectors"
* We'll stick to the basics. You can find all [CSS selector rules here](https://www.w3schools.com/cssref/css_selectors.asp):

### CSS Selector rules
* To select a node of a name, simply use the node: `div`
* To select a node anywhere within a different node, use the outer node followed by a space, then the inner node: `body h1`
* To select an element with a given id use # followed by the id: `#abstract`
* To select *all* elements of a given class, use . followed by the class name: `.article-text`. *Remember:* There can be (and often are) multiple elements with the same class.
* To select a specific element of a given class (or id), simply join them together `div.article-text`
* To select an element based on a different attribute, use `[attribute="value"]`, i.e. `[description="special-content"]`

### Exercise
Looking at a specific Assembly Member, [Khaleel Anderson](https://nyassembly.gov/mem/Khaleel-M-Anderson), what would the CSS selector be for his district?

### A Helpful Tool
* There are many tools that can help you to generate CSS selectors. I like the css selector gadget, which comes as a [Chrome Extension](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb?hl=en) and a [bookmarklet](https://selectorgadget.com/)
* By allowing you to select elements in and out of the selection, it makes it easy to generate a CSS selector

### Exercise
* Using the CSS Selector Gadget, on the [directory of the Assembly](https://nyassembly.gov/mem/) find a CSS Selector that includes all email addresses, but nothing else.

* Caution: The CSS Selector Gadget is wonderfully helpful, but it *can* lead you astray by producing overly specific selectors.

**[Go to the next page](first-steps-r)**
