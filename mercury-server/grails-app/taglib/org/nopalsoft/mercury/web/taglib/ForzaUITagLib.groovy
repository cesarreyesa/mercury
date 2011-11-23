package org.nopalsoft.mercury.web.taglib

import org.springframework.web.servlet.support.RequestContextUtils as RCU
import org.nopalsoft.nectar.util.HumanTime;

class ForzaUITagLib {
   static namespace = "f"

   def humanTime = { attrs ->
      Date time = attrs.date('time')
      out << HumanTime.approximately(time.time - new Date().time)
   }

   def paginate = { attrs ->
      def writer = out
      writer << '<ul>'
      if (attrs.total == null) {
         throwTagError("Tag [paginate] is missing required attribute [total]")
      }
      def messageSource = grailsAttributes.messageSource
      def locale = RCU.getLocale(request)

      def total = attrs.int('total') ?: 0
      def action = (attrs.action ? attrs.action : (params.action ? params.action : "list"))
      def offset = params.int('offset') ?: 0
      def max = params.int('max')
      def maxsteps = (attrs.int('maxsteps') ?: 10)

      if (!offset) offset = (attrs.int('offset') ?: 0)
      if (!max) max = (attrs.int('max') ?: 10)

      def linkParams = [:]
      if (attrs.params) linkParams.putAll(attrs.params)
      linkParams.offset = offset - max
      linkParams.max = max
      if (params.sort) linkParams.sort = params.sort
      if (params.order) linkParams.order = params.order

      def linkTagAttrs = [action: action]
      if (attrs.controller) {
         linkTagAttrs.controller = attrs.controller
      }
      if (attrs.id != null) {
         linkTagAttrs.id = attrs.id
      }
      if (attrs.fragment != null) {
         linkTagAttrs.fragment = attrs.fragment
      }
      linkTagAttrs.params = linkParams

      // determine paging variables
      def steps = maxsteps > 0
      int currentstep = (offset / max) + 1
      int firststep = 1
      int laststep = Math.round(Math.ceil(total / max))

      // display previous link when not on firststep
      linkParams.offset = offset - max
      if (currentstep > firststep) {
         writer << '<li class="prev">'
//         linkTagAttrs.class = 'prevLink'
      }
      else{
         writer << '<li class="prev disabled">'
      }
      writer << link(linkTagAttrs.clone()) {
         (attrs.prev ?: "&larr; " + messageSource.getMessage('paginate.prev', null, messageSource.getMessage('default.paginate.prev', null, 'Previous', locale), locale))
      }
      writer << '</li>'

      // display steps when steps are enabled and laststep is not firststep
      if (steps && laststep > firststep) {
         //linkTagAttrs.class = 'step'

         // determine begin and endstep paging variables
         int beginstep = currentstep - Math.round(maxsteps / 2) + (maxsteps % 2)
         int endstep = currentstep + Math.round(maxsteps / 2) - 1

         if (beginstep < firststep) {
            beginstep = firststep
            endstep = maxsteps
         }
         if (endstep > laststep) {
            beginstep = laststep - maxsteps + 1
            if (beginstep < firststep) {
               beginstep = firststep
            }
            endstep = laststep
         }

         // display firststep link when beginstep is not firststep
         if (beginstep > firststep) {
            linkParams.offset = 0
            writer << '<li>'
            writer << link(linkTagAttrs.clone()) {firststep.toString()}
            writer << '</li>'
            writer << '<li>..</li>'
         }

         // display paginate steps
         (beginstep..endstep).each { i ->
            if (currentstep == i) {
               writer << "<li class=\"active\">" + link(linkTagAttrs.clone()) {i.toString()} + "</li>"
            }
            else {
               writer << '<li>'
               linkParams.offset = (i - 1) * max
               writer << link(linkTagAttrs.clone()) {i.toString()}
               writer << '</li>'
            }
         }

         // display laststep link when endstep is not laststep
         if (endstep < laststep) {
            writer << '<li>..</li>'
            linkParams.offset = (laststep - 1) * max
            writer << link(linkTagAttrs.clone()) { laststep.toString() }
         }
      }

      // display next link when not on laststep
      writer << '<li>'
      if (currentstep < laststep) {
         linkParams.offset = offset + max
         writer << '<li>'
      }else{
         writer << '<li class="disabled">'
      }
      writer << link(linkTagAttrs.clone()) {
         (attrs.next ? attrs.next : (messageSource.getMessage('paginate.next', null, messageSource.getMessage('default.paginate.next', null, 'Next', locale), locale) + " &rarr;"))
      }
      writer << '</li>'
      writer << '</ul>'
   }

   def textField = { attrs ->
//      <div class="clearfix ${hasErrors(bean: hotel, field: 'baseName', 'error')} required">
//         <label for="baseName">
//            <g:message code="hotel.baseName.label" default="Name" />
//            <span class="required-indicator">*</span>
//         </label>
//         <div class="input">
//            <g:textField name="baseName" required="" value="${hotel?.baseName}"/>
//         </div>
//      </div>
      def writer = out
      writer << "<div class=\"clearfix"
      writer << hasErrors(bean: attrs.bean, field: attrs.field, 'errors')
      writer << "\">"
      writer << "<label for=\"$attrs.field\">"
      writer << message(code: '')
      writer << '</div>'
   }
}

