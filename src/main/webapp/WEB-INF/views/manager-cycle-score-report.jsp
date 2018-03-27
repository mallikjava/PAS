<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>Softvision | PMS</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico">
    <!-- Bootstrap Core Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap/css/bootstrap.css">
    <!-- Waves Effect Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/node-waves/waves.css"/>
    <!-- Bootstrap Material Datetime Picker Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" />
    <!-- Animation Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/animate-css/animate.css"/>
    <!-- Sweetalert Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/sweetalert/sweetalert.css"/>
    <!-- Custom Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/css/style.css">
    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/css/themes/all-themes.css">
  </head>
  <style>
  .list-group-item {
  	font-size: 13px;
  }
  </style>
</head>

<body class="theme-red">
  <!-- Header -->
  <%@include file="common/header.jsp" %>
  <!-- =============================================== -->

  <!-- Left side column. contains the sidebar -->
  <%@include file="common/menu.jsp" %>
  <!-- =============================================== -->

  <section class="content">
    <div class="container-fluid">
      <div class="block-header">
        <h2>Employee Assignments
          <small>View status of the current employees those are assigned to you, change manager, enable forms, view assessment or conclude</small>
        </h2>
      </div>
      <%@include file="common/no-cycle.jsp" %>
    </div>
  </section>
</body>

<!-- Jquery Core Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap Core Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap/js/bootstrap.js"></script>
<!-- Select Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<!-- Slimscroll Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
<!-- Waves Effect Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/node-waves/waves.js"></script>
<!-- Autosize Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/autosize/autosize.js"></script>
<!-- Moment Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/momentjs/moment.js"></script>
<!-- Bootstrap Material Datetime Picker Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<!-- SweetAlert Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/sweetalert/sweetalert.min.js"></script>
<!-- Validation Plugin Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery-validation/jquery.validate.js"></script>
<!-- Custom Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/admin.js"></script>
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/pages/ui/tooltips-popovers.js"></script>
<!-- Demo Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/demo.js"></script>
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery-datatable/jquery.dataTables.js"></script>

<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/common.js"></script>
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery-Sprite-Preloaders/jquery.preloaders.min.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/ajax-wrapper.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/card-manager.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/phase-score-report.js"></script>
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/pages/ui/modals.js"></script>
<script>
$(function () {
  $.fn.scoreReport=function( options ) {
    var settings=$.extend({
      contextPath: null,
	  url: null,
	}, options );

    var obj=$(this);
    $.fn.ajaxGet({
   	  url: settings.url,
      onSuccess: renderAssignments,
      onError: onErrorScoreReport
    });

    function renderAssignments(data) {
      if (data == null || data.length == 0) {
    	showErrorCard('There are no assignments found');
      } else{
    	renderScoreReport(data);
      }
    }
    
    function renderScoreReport(data) {
      for (var index = 0; index < data.length; index++) {
       	var cycleAssignment = data[index];
       	var cycle=cycleAssignment.cycle;
       	var cycleStatus=getAppraisalCycleStatus(cycle.status);
       	if (cycleStatus == AppraisalCycleStatus.DRAFT) {
       		continue;
       	}
        var cardRow=$('<div class="row clearfix">');
        var cardColumn=$('<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">');
        var card=$('<div class="card">');
        var cardHeader=$('<div class="header">');
        $(cardHeader).addClass(cycleStatus.colorClass);
        var cardTitle=$('<h2>' + cycle.name + '</h2>');
        var cardBody=$('<div class="body">');

        var phaseAssignments=cycleAssignment.phaseAssignments;
        $(phaseAssignments).each(function(jindex, phaseAssignment) {
          var phase=phaseAssignment.phase;

          var table=$('<table class="table table-striped">');
          var thead=$('<thead>');
          var tbody=$('<tbody>');
          var theadRow=$('<tr>');

          $(theadRow).append('<th width="15%">Employee ID</th>');
          $(theadRow).append('<th width="35%">Employee Name</th>');
          $(theadRow).append('<th>Status</th>');
          $(theadRow).append('<th width="15%">Score</th>');

          var employeeAssignments=phaseAssignment.employeeAssignments;
          if (employeeAssignments != null) {
       	    $(employeeAssignments).each(function(kindex, ea) {
   	    	  var assignedTo=ea.assignedTo;
           	  var assignedBy=ea.assignedBy;
           	  var phaseStatus=getPhaseAssignmentStatus(ea.status);

   	    	  var row=$('<tr>');
           	  $(row).append('<td item-id="' + ea.assignmentId + '">' + assignedTo.EmployeeId + '</td>');
              $(row).append('<td>' + assignedTo.FirstName + ' ' + assignedTo.LastName + '</td>');
              $(row).append('<td>' + getPhaseStatusLabel(ea.status) + '</td>');
              if (phaseStatus == PhaseAssignmentStatus.CONCLUDED) {
                $(row).append('<td><b>' + ea.score + '</b></td>');
              } else {
                $(row).append('<td>-</td>');
              }
              $(tbody).append(row);
        	});
          }
          var phaseTitle=$('<h5 class="font-underline col-cyan">Phase: ' + phase.name + '</h5>');
          $(cardBody).append(phaseTitle);
          $(cardBody).append(table);
          $(table).append(thead);
          $(table).append(tbody);
          $(thead).append(theadRow);
        });

        $(obj).append(cardRow);
        $(cardRow).append(cardColumn);
        $(cardColumn).append(card);
        $(card).append(cardHeader);
        $(cardHeader).append(cardTitle);
        $(card).append(cardBody);
      }
    }

    function onErrorScoreReport(error) {
      showErrorCard('Errors occurred while retreiving assignment information. Cause: ' + JSON.stringify(error));
    }

  }

  $('.container-fluid').scoreReport({
	contextPath: '<%=request.getContextPath()%>',
  	url: '<%=request.getContextPath()%>/manager/report/score',
  });

});

</script>
</html>
