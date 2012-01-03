<%--
  User: cesarreyes
  Date: 28/11/11
  Time: 06:39
--%>

<%@ page import="org.nopalsoft.mercury.domain.MessageComment; org.nopalsoft.mercury.domain.IssueComment" contentType="text/html;charset=UTF-8" %>
<g:if test="${mode == 'comment'}">
   <div class="comment">
      <p>
         <img src="http://www.gravatar.com/avatar/${comment.user.email.encodeAsMD5()}?s=30" alt="gravatar">
         <strong>${comment.user.fullName}</strong> <g:formatDate date="${comment.dateCreated}" format="MMM dd, yyyy @ HH:mm"/>
      </p>
      <g:if test="${comment instanceof IssueComment}">
         <g:if test="${comment.action == 'assign' && comment.relatedUser}">
            <strong><g:message code="comment.issue.${comment.action}"/></strong> la incidencia
            <g:if test="${comment.action == 'assign' && comment.relatedUser}">
               a ${comment.relatedUser}
            </g:if>
         </g:if>
      </g:if>
      <p><g:markdownToHtml>${comment.content}</g:markdownToHtml></p>
   </div>
</g:if>
<g:else>
   <div class="activity" style="clear: both;">
      <div style="float: left;padding: 3px;">
         <img src="http://www.gravatar.com/avatar/${comment.user.email.encodeAsMD5()}?s=25" alt="gravatar">
      </div>
      <g:if test="${comment instanceof IssueComment}">
         <div>
            <strong>${comment.user}</strong> <strong><g:message code="comment.issue.${comment.action}"/></strong>
            la incidencia <g:link controller="issues" action="view" id="${comment.issue.id}">${comment.issue.code}</g:link>
            <g:if test="${comment.action == 'assign' && comment.relatedUser}">
               a ${comment.relatedUser}
            </g:if>
            hace <f:humanTime time="${comment.dateCreated}"/>
         </div>
         <div>
            <div style="float: left;color: #a0a0a0;padding-left: 10px;">
               <g:if test="${comment.action == 'create'}">
                  <p>${comment.issue.summary}</p>
               </g:if>
               <g:if test="${comment.content}">
                  <p>${comment.content}</p>
               </g:if>
            </div>
         </div>
      </g:if>
      <g:elseif test="${comment instanceof MessageComment}">
         <div>
            <strong>${comment.user}</strong> edit&oacute;
            el mensaje <g:link controller="messages" action="view" id="${comment.message.id}">${comment.message.title}</g:link>
            hace <f:humanTime time="${comment.dateCreated}"/>
         </div>
         <div>
            <div style="float: left;color: #a0a0a0;padding-left: 10px;">
               %{--<g:if test="${activity.action == 'create'}">--}%
                  %{--<p>${activity.message.body}</p>--}%
               %{--</g:if>--}%
               %{--<g:if test="${activity.content}">--}%
                  %{--<p>${activity.content}</p>--}%
               %{--</g:if>--}%
            </div>
         </div>
      </g:elseif>
      <g:else>
         <div>
            <strong>${comment.user}</strong> hace <f:humanTime time="${comment.dateCreated}"/>
         </div>
         <div>
            <div style="float: left;color: #a0a0a0;padding-left: 10px;">
               <p>${comment.content}</p>
            </div>
         </div>
      </g:else>
   </div>
</g:else>
