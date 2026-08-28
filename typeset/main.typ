#import "@preview/min-book:1.5.1": book, themes
#set page(paper: "us-statement") //statement for half-letter size
#show: book.with(
  title: "Book title",
  subtitle: "Subtitle here",
  authors: "author(s)",
  cfg: (theme: themes.coffee)
)

#include "chapters/chapter1.typ"
