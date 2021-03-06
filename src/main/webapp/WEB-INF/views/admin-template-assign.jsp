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
    <!-- Bootstrap Select Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-select/css/bootstrap-select.css"  />
    <!-- EasyAutocomplete-1.3.5 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/EasyAutocomplete-1.3.5/easy-autocomplete.min.css"/>
    <!-- Bootstrap Tagsinput Css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css"/>
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
        <h2>Assign Templates to Employees
          <small>Select a cycle, phase, a template and the employees to assign</small>
        </h2>
      </div>
      <%@include file="common/no-cycle.jsp" %>

      <div class="row clearfix">
        <div class="col-lg-12 col-md-50 col-sm-12 col-xs-12">
          <div class="card template_assign_card">
            <div class="header"><h2>Goal Settings / Assign Templates</h2></div>
            <div class="body">
              <div class="row clearfix">
			    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 form-control-label">
                  <label for="AppraisalCycle_Name">Appraisal Cycle</label>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
		          <select id="AppraisalCycle_Name" class="form-control show-tick">
	              </select>
                </div>
			    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 form-control-label">
                  <label for="AppraisalPhase_Name">Appraisal Phase</label>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
		          <select id="AppraisalPhase_Name" class="form-control show-tick">
	              </select>
                </div>
              </div>
              <div class="row clearfix">
			    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 form-control-label">
                  <label for="Template_Name">Template Name</label>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
		          <div class="form-group form-float">
		            <div class="form-line">
		              <input type="text" id="Template_Name" class="form-control" placeholder="Start entering template name" required autofocus value="">
                    </div>
                  </div>
                </div>
              </div>
              <div class="row clearfix">
			    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 form-control-label">
                  <label for="Search_Employees">Select Employees</label>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
		          <div class="form-group form-float">
		            <div class="form-line">
		              <input type="text" id="Search_Employees" class="form-control" placeholder="Enter employee ID or name" value="">
                    </div>
                  </div>
                </div>
              </div>
              <div class="row clearfix">
			    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1">&nbsp;</div>
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
		          <table class="table table-striped" id="Selected_Employees_Table">
		            <thead>
		              <tr>
		                <th>ID</th>
		                <th>Name</th>
		                <th>Designation</th>
		                <th>Band</th>
		                <th>Action</th>
		                <th>Status</th>
		              </tr>
		            </thead>
		            <tbody>
		            </tbody>
                  </table>
                </div>
			    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1">&nbsp;</div>
              </div>
              <div class="row clearfix">
			    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			    <div class="text-right">
		          <button id="Reset_Button" class="btn btn-primary">Reset</button>
		          <button id="Assign_Button" class="btn btn-primary">Assign</button>
		          </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</body>
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
<!-- EasyAutocomplete-1.3.5 -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/EasyAutocomplete-1.3.5/jquery.easy-autocomplete.min.js"></script>
<!-- EasyAutocomplete-1.3.5 -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
<!-- Custom Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/admin.js"></script>
<!-- Demo Js -->
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/js/demo.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/common.js"></script>
<script src="<%=request.getContextPath()%>/AdminBSBMaterialDesign/plugins/jquery-Sprite-Preloaders/jquery.preloaders.min.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/ajax-wrapper.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/render-card.js"></script>
<script src="<%=request.getContextPath()%>/scripts/AdminBSBMaterialDesign/active-cycle-check.js"></script>
<script>
var bulkAssignment={};
/* bulkAssignment.templateId=5;
bulkAssignment.cycleId=4;
bulkAssignment.employeeIds=[1136,2388,2006]; */

bulkAssignment.templateId=0;
bulkAssignment.cycleId=0;
bulkAssignment.phaseId=0;
bulkAssignment.employeeIds=[];

$(function () {
  $.fn.activeCycleCheck({
	contextPath: '<%=request.getContextPath()%>',
	errorMessage: 'There is no Appraisal Cycle ACTIVE right now! You can assign a template to employees only when there is an appraisal cycle is ACTIVE',
	onAvailable: function (cycle) {
	  //bulkAssignment.cycleId=cycle.id;
	}
  });

  var assignableCycles=[];
  $.fn.ajaxGet({
	url : '<%=request.getContextPath()%>/appraisal/get/assignable',
	onSuccess: function(result) {
	  assignableCycles=result;
	  $.each(result, function(index, cycle) {
		var flag=(cycle.status=="ACTIVE")?'Selected':' ';
		$('#AppraisalCycle_Name').append('<option value="'+cycle.id+'"'+flag+'>'+cycle.name+'</option>');
	  });
	  $("#AppraisalCycle_Name").selectpicker("refresh");

	  $("#AppraisalCycle_Name").change(function() {
		var selectedCycle=$(this).val();
		$('#AppraisalPhase_Name option').remove();
		$(assignableCycles).each(function (index, cycle) {
		  if (cycle.id==selectedCycle) {
			$(cycle.phases).each(function(jindex, phase) {
			  $('#AppraisalPhase_Name').append('<option value="' + phase.id + '">' + phase.name + '</option>');
			});
		  }
		});
	    $("#AppraisalPhase_Name").selectpicker("refresh");
		$("#AppraisalPhase_Name").trigger('change');
	    bulkAssignment.cycleId=selectedCycle;
	  });
	  $("#AppraisalCycle_Name").trigger('change');
	  bulkAssignment.phaseId=$("#AppraisalPhase_Name").val();
	}
  });

  $("#AppraisalPhase_Name").change(function() {
    bulkAssignment.phaseId=$("#AppraisalPhase_Name").val();
  });

  $("#Template_Name").easyAutocomplete({
    url: function(phrase) {
	  return "<%=request.getContextPath()%>/template/search/byName/" + phrase;
	},
	dataType: "json",
	getValue: "name",
	template: {
	  type: "custom",
	  method: function(value, template) {
		var employeeName=template.updatedBy.fullName;
		return "<b>" + template.name + "</b><small> - Updated By <code>" + employeeName + "</code> on <code>" + template.updatedAt + "</code></small>";
	  }
	},
	list: {
	  maxNumberOfElements: 10,
	  onClickEvent: function() {
		bulkAssignment.templateId=$("#Template_Name").getSelectedItemData().id;
	  }	
	}
  });

  $("#Search_Employees").easyAutocomplete({
	url: function(phrase) {
	  return "<%=request.getContextPath()%>/employee/search/" + phrase;
	},
	dataType: "json",
	getValue: function (item) { return item.fullName},
	template: {
	  type: "custom",
	  method: function(value, item) {
		return "<b>" + item.fullName + "</b> [<code>" + item.employeeId + "</code>]</small>";
	  }
	},
	list: {
	  maxNumberOfElements: 15,
	  onClickEvent: function() {
		var data=$("#Search_Employees").getSelectedItemData();
		var itemId=data.employeeId;
		var itemValue=data.fullName;
		var table=$('#Selected_Employees_Table');
		var tbody=$(table).find('tbody');

		if($(tbody).find('tr:has(td:first:contains("' + itemId + '"))').length == 0) {
		  var row=$('<tr>');
		  $(row).append('<td>' + itemId + '</td>');
		  $(row).append('<td>' + itemValue + '</td>');
		  $(row).append('<td>' + data.designation + '</td>');
		  $(row).append('<td>' + data.band + '</td>');
		  var deleteIcon=$('<i class="material-icons col-orange delete_icon" style="cursor: pointer;">delete</i>');
		  $(deleteIcon).click(function() {
		    $(row).remove();
			bulkAssignment.employeeIds=$.grep(bulkAssignment.employeeIds, function(value) { return value != itemId;});
		  });
		  $(deleteIcon).tooltip({container: 'body'});
		  var actionCell=$('<td>');
		  $(actionCell).append(deleteIcon);
		  $(row).append(actionCell);
		  $(row).append('<td>&nbsp;</td>');
		  $(tbody).append(row);
		  bulkAssignment.employeeIds.push(itemId);
		}
		$("#Search_Employees").val('');
	  }	
	}
  });

  $('#Assign_Button').click(function() {
	var button=this;
	if (bulkAssignment.phaseId == 0) {
      swal({title: "Missing Information", text: "Please select a phase", type: "warning"});
	} else if (bulkAssignment.templateId == 0) {
	  swal({title: "Missing Information", text: "Please select a template", type: "warning"});
    } else if (bulkAssignment.employeeIds.length == 0) {
	  swal({title: "Missing Information", text: "Please select at least an employee to assign", type: "warning"});
    } else {
   	  swal({
		title: "Are you sure?", text: "Do you want to assign this template to the selected employees?", type: "warning",
		showCancelButton: true, confirmButtonColor: "#DD6B55",
	    confirmButtonText: "Yes, Assign!", closeOnConfirm: false, showLoaderOnConfirm: true
	  }, function () {
	      $(button).attr('disabled', true);
		  $.fn.ajaxPost({url:'<%=request.getContextPath()%>/assignment/save/bulk', data: bulkAssignment,
		  onSuccess: function(message, content) {
			var table=$('#Selected_Employees_Table');
			var tbody=$(table).find('tbody');
	      	// Delete delete button
	      	$('.delete_icon').removeClass('col-orange').css({'cursor':"default"}).attr('onclick','').unbind('click');

			$(content).each(function(index, aResult) {
			  var employeeId=aResult.content;
			  var actionStatus=null;
			  if (aResult.code=='SUCCESS') {
				actionStatus=$('<i class="material-icons col-green" data-toggle="tooltip" data-placement="top" title="' + aResult.message + '">check_circle</i>');
			  } else {
				actionStatus=$('<i class="material-icons col-red" data-toggle="tooltip" data-placement="top" title="' + aResult.message + '">error</i>');
			  }
			  $(actionStatus).tooltip({container: 'body'});
			  var cell=$(tbody).find('tr td:contains(' + employeeId + ')');
			  $(cell).siblings().last().html(actionStatus);
		    });
			swal({ title: "Completed!", text: message, type: "success"}, function () { });
		  },
		  onFail: function(message, content) {
		    swal({ title: "Failed!", text: message, type: "error"}, function () { });
		  },
    	  onComplete : function (result) {
    		$(button).attr('disabled', false);
  	      }
	    });
	  });
    }
  });

  $('#Reset_Button').click(function() {
	bulkAssignment.templateId=0;
	bulkAssignment.cycleId=0;
	bulkAssignment.phaseId=0;
	bulkAssignment.employeeIds=[];
	
	$("#Template_Name").val('');
	$("#Search_Employees").val('');
	var table=$('#Selected_Employees_Table');
	var tbody=$(table).find('tbody');
	$(tbody).empty();
  });

});

</script>
</html>
