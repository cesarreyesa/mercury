<%--
  User: cesarreyes
  Date: 07/07/11
  Time: 23:24
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<style type="text/css">
   .comments{
      background-color:#F9F9FA;border: 1px solid #ccc;padding:5px;
   }

   .comments .summary{
      /*background-color: #ccc;*/
      padding-bottom: 10px;
   }

   .comments .addComment .title{
      font-weight: bold;
   }

   .comments .addComment .text{
      width:100%;border: 2px solid #ccc;
      margin-bottom: 5px;
      margin-top: 5px;
   }
</style>

<div class="comments">
   <div class="summary">
      ${conversation.comments.size() ?: 0} comentarios hasta ahora
      <hr/>
   </div>

   <g:each in="${conversation.comments}" var="comment">
      <div class="comment">
         <p>${comment.dateCreated} | ${comment.user.fullName}</p>
         <p>${comment.content}</p>
      </div>
   </g:each>
   <div class="addComment">
      <g:form controller="conversation" action="addComment" id="${conversation.id}">
         <g:hiddenField name="url" value="${request.forwardURI}"/>
         <div class="title">Agregar un comentario</div>
         <g:textArea name="comment" class="text" rows="2" cols="30"/>
         <g:submitButton name="addComment" class="button" value="Enviar"/>
      </g:form>
   </div>
</div>

<script type="text/javascript">
   $(".button").button();
</script>
