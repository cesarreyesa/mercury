<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 13/03/11
  Time: 22:57
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Reporte de ${message(code: 'nectar.tasks.lower')}</title>
   <meta name="layout" content="main"/>
</head>
<body>
<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'reports']"/>
</content>

<div id="main">
   <div class="block" id="block-tables">
      <div class="content">
         <h2 class="title">Reporte de <g:message code="nectar.tasks"/></h2>
         <div class="inner">
            <g:form action="issues">
               <button id="projects">Proyectos</button>
               <div id="projectsCt" class="multiselect" style="display:none;">
                  <g:select style="width:250px;" from="${projects}" name="project" optionKey="id" optionValue="name" multiple="true" noSelection="${['':'Todos']}"/>
               </div>
               <button id="statuses">Estado</button>
               <div id="statusesCt" class="multiselect" style="display:none;">
                  <g:select style="width:250px;" from="${statuses}" name="status" optionKey="code" optionValue="name" multiple="true" noSelection="${['':'Todos']}"/>
               </div>
               <input type="text" name="from" id="from" class="date"/>
               <input type="text" name="to" id="to" class="date"/>
               <g:submitButton name="issues" value="Filtrar"/>
            </g:form>
            <g:render template="/shared/issuesTable" model="[issues:issues]"/>
         </div>
      </div>
   </div>
</div>

<script type="text/javascript">
$(function() {
   var dates = $( "#from, #to" ).datepicker({
      showOn: 'both',
      buttonImageOnly: true,
      buttonImage: "${resource(dir:'images/icons', file:'calendar.png')}",
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 2,
      onSelect: function( selectedDate ) {
         var option = this.id == "from" ? "minDate" : "maxDate",
            instance = $( this ).data( "datepicker" );
            date = $.datepicker.parseDate(
               instance.settings.dateFormat ||
               $.datepicker._defaults.dateFormat,
               selectedDate, instance.settings );
         dates.not( this ).datepicker( "option", option, date );
      }
   });

   $('#projects').button();
   $('#projects').click(function(e){
      e.preventDefault();
      $('#projectsCt').toggle();

   });

   $('#statuses').button();
   $('#statuses').click(function(e){
      e.preventDefault();
      $('#statusesCt').toggle();

   });
});
</script>

</body>
</html>