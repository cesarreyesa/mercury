<%--
  User: cesarreyes
  Date: 07/07/11
  Time: 23:24
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<style type="text/css">
   .comments{
      padding-bottom:5px;
   }

   .comments .summary{
      /*background-color: #ccc;*/
      padding-bottom: 10px;
      margin-bottom: 10px;
      border-bottom: 1px solid #ccc;
   }

   .comments .addComment{
      padding-top: 10px;
   }

   .comments .addComment .title{
      font-weight: bold;
   }

   .comments .addComment .text{
      width:100%;border: 2px solid #ccc;
      margin-bottom: 5px;
      margin-top: 5px;
   }

   .comments .comment{
      border-bottom: 1px solid #ccc;
      margin-bottom: 10px;
   }
</style>

<div class="well comments">
   <div class="summary">
      ${conversation.comments.size() ?: 0} comentarios hasta ahora
   </div>

   <g:each in="${conversation.comments.sort { c -> c.dateCreated }}" var="comment">
      <div class="comment">
         <p>
            <img src="http://www.gravatar.com/avatar/${session.user.email.encodeAsMD5()}?s=30" alt="gravatar">
            <strong>${comment.user.fullName}</strong> <g:formatDate date="${comment.dateCreated}" format="MMM dd, yyyy @ HH:mm"/>
         </p>
         <p><g:markdownToHtml>${comment.content}</g:markdownToHtml></p>
      </div>
   </g:each>
   <div class="addComment">
      <g:form controller="${controller}" action="addComment" id="${conversation.id}">
         <g:hiddenField name="url" value="${request.forwardURI}"/>
         <div class="title">Agregar un comentario</div>
         <g:textArea name="comment" class="text" rows="2" cols="30" style="height:50px;"/>
         <g:submitButton name="addComment" class="btn" value="Enviar"/>
      </g:form>
   </div>
</div>

<script type="text/javascript">
   //$('div.addComment textarea').markItUp(mySettings);
</script>
