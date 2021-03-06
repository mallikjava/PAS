package com.softvision.ipm.pms.template.rest;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.softvision.ipm.pms.common.constants.AuthorizeConstant;
import com.softvision.ipm.pms.common.model.Result;
import com.softvision.ipm.pms.common.util.RestUtil;
import com.softvision.ipm.pms.employee.model.EmployeeDto;
import com.softvision.ipm.pms.template.model.TemplateDto;
import com.softvision.ipm.pms.template.service.TemplateService;

@RestController
@RequestMapping(value="template", produces=MediaType.APPLICATION_JSON_VALUE)
public class TemplateRest {

	@Autowired private TemplateService templateService;

	@RequestMapping(value="list", method=RequestMethod.GET)
    public @ResponseBody List<TemplateDto> geTemplates() {
		return templateService.getTemplates();
    }

	@RequestMapping(value="list/{id}", method=RequestMethod.GET)
    public @ResponseBody TemplateDto getTemplate(@PathVariable(required=true) @NotNull long id) {
		return templateService.getTemplate(id);
    }

	@RequestMapping(value="list/new", method=RequestMethod.GET)
    public @ResponseBody TemplateDto getNewTemplate() {
		return templateService.getNewTemplate();
    }

	@PreAuthorize(AuthorizeConstant.IS_MANAGER_OR_ADMIN)
	@RequestMapping(value="save", method=RequestMethod.POST)
    public Result save(@RequestBody(required=true) @NotNull TemplateDto template) {
		Result result = new Result();
		try {
			// set updatedBy & updatedAt
			int loggedInEmployeeId = RestUtil.getLoggedInEmployeeId();
			EmployeeDto updatedBy = new EmployeeDto();
			updatedBy.setEmployeeId(loggedInEmployeeId);
			template.setUpdatedBy(updatedBy);
			template.setUpdatedAt(new Date());
			TemplateDto updated = templateService.update(template);
			result.setCode(Result.SUCCESS);
			result.setContent(updated);
		} catch (Exception exception) {
			result.setCode(Result.FAILURE);
			result.setMessage(exception.getMessage());
		}
		return result;
    }

	@RequestMapping(value="search/byName/{searchString}", method=RequestMethod.GET)
	public @ResponseBody List<TemplateDto> search(
    		@PathVariable(value="searchString", required=true) String searchString) {
		return templateService.searchName(searchString);
    }

	@PreAuthorize(AuthorizeConstant.IS_MANAGER_OR_ADMIN)
	@RequestMapping(value="delete/{id}", method=RequestMethod.DELETE)
    public @ResponseBody Result delete(@PathVariable(required=true) @NotNull @Min(1) long id) {
		Result result = new Result();
		try {
			templateService.delete(id);
			result.setCode(Result.SUCCESS);
		} catch (Exception exception) {
			result.setCode(Result.FAILURE);
			result.setMessage(exception.getMessage());
		}
		return result;
    }

}
