package org.nopalsoft.mercury.web.taglib

import com.petebevin.markdown.MarkdownProcessor

class MarkdownTagLib {

   def markdownToHtml = { attrs, body ->
      out << new MarkdownProcessor().markdown(body().toString())
   }

}
