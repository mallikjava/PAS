package com.softvision.ipm.pms.web.config;

import java.util.Properties;

import javax.mail.Session;

import org.modelmapper.ModelMapper;
import org.modelmapper.config.Configuration.AccessLevel;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.LdapContextSource;

import com.softvision.ipm.pms.assess.entity.AssessDetail;
import com.softvision.ipm.pms.assess.entity.AssessHeader;
import com.softvision.ipm.pms.assess.model.AssessDetailDto;
import com.softvision.ipm.pms.assess.model.AssessHeaderDto;
import com.softvision.ipm.pms.assign.entity.CycleAssignment;
import com.softvision.ipm.pms.assign.entity.PhaseAssignment;
import com.softvision.ipm.pms.assign.model.EmployeeAssignmentDto;
import com.softvision.ipm.pms.employee.entity.Employee;
import com.softvision.ipm.pms.employee.model.EmployeeDto;
import com.softvision.ipm.pms.goal.entity.Goal;
import com.softvision.ipm.pms.goal.entity.GoalParam;
import com.softvision.ipm.pms.goal.model.GoalDto;
import com.softvision.ipm.pms.goal.model.GoalParamDto;
import com.softvision.ipm.pms.template.entity.Template;
import com.softvision.ipm.pms.template.entity.TemplateDetail;
import com.softvision.ipm.pms.template.entity.TemplateHeader;
import com.softvision.ipm.pms.template.model.TemplateDetailDto;
import com.softvision.ipm.pms.template.model.TemplateDto;
import com.softvision.ipm.pms.template.model.TemplateHeaderDto;
import com.softvision.ipm.pms.user.model.User;

@Configuration
public class ExternalBeanConfiguration {

	@Value("${app.security.ldap.url}") private String ldapUrl;

	@Value("${app.security.ldap.authentication}") private String authenticationUsed;

	@Value("${app.security.ldap.domain}") private String domain;

	@Value("${app.email.host}") private String emailHost;

	// TODO: 
	// 1. Create LDAP Connection source
	// 2. Free Marker template
	@Bean
	public freemarker.template.Configuration getEmailConfiguration() {
		// Freemarker configuration object
        freemarker.template.Configuration configuration = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_25);
        configuration.setDefaultEncoding("UTF-8");
        configuration.setClassForTemplateLoading(this.getClass(), "/templates");
		return configuration;
	}

	@Bean
    public LdapContextSource contextSource () {
        LdapContextSource contextSource= new LdapContextSource();
        contextSource.setUrl(ldapUrl);
        //contextSource.setBase(env.getRequiredProperty("ldap.base"));
        //contextSource.setUserDn(env.getRequiredProperty("ldap.user"));
        //contextSource.setPassword(env.getRequiredProperty("ldap.password"));
        return contextSource;
    }

	@Bean
    public LdapTemplate ldapTemplate() {
        return new LdapTemplate(contextSource());        
    }

	@Bean
	public Session getEmailSession() {
		Properties PROPERTIES = new Properties();
		PROPERTIES.setProperty("mail.smtp.host", emailHost);
		// Get the default Session object.
		return Session.getDefaultInstance(PROPERTIES);
	}

	@Bean
	public ModelMapper getModelMapper() {
		ModelMapper mapper = new ModelMapper() {
		    @Override
		    public <D> D map(Object source, Class<D> destinationType) {
		        if (source == null) {
		            return null;
		        }
		        return super.map(source, destinationType);
		    }
		};
		mapper.getConfiguration().setFieldMatchingEnabled(true).setFieldAccessLevel(AccessLevel.PRIVATE).setMatchingStrategy(MatchingStrategies.STRICT);

		// AppraisalCycle mappings
		/*mapper.typeMap(AppraisalCycle.class, AppraisalCycleDto.class)
        .addMapping(src -> src.getId(), AppraisalCycleDto::setId)
        .addMapping(src -> src.getName(), AppraisalCycleDto::setName)
        .addMapping(src -> src.getStartDate(), AppraisalCycleDto::setStartDate)
        .addMapping(src -> src.getEndDate(), AppraisalCycleDto::setEndDate)
        .addMapping(src -> src.getCutoffDate(), AppraisalCycleDto::setCutoffDate)
        .addMapping(src -> src.getStatus(), (dest, value) -> dest.setStatus(AppraisalCycleStatus.get((String)value)))
        .addMapping(src -> src.getPhases(), AppraisalCycleDto::setPhases);

		mapper.typeMap(AppraisalPhase.class, AppraisalPhaseDto.class)
        .addMapping(src -> src.getId(), AppraisalPhaseDto::setId)
        .addMapping(src -> src.getName(), AppraisalPhaseDto::setName)
        .addMapping(src -> src.getStartDate(), AppraisalPhaseDto::setStartDate)
        .addMapping(src -> src.getEndDate(), AppraisalPhaseDto::setEndDate);*/

		// Goal Mappings
		mapper.typeMap(Goal.class, GoalDto.class)
		.addMapping(src -> src.getId(), GoalDto::setId)
		.addMapping(src -> src.getName(), GoalDto::setName)
		.addMapping(src -> src.getParams(), GoalDto::setParams);

		mapper.typeMap(GoalParam.class, GoalParamDto.class)
        .addMapping(src -> src.getId(), GoalParamDto::setId)
        .addMapping(src -> src.getName(), GoalParamDto::setName)
        .addMapping(src -> src.getApply(), GoalParamDto::setApplicable);

		mapper.typeMap(GoalDto.class, Goal.class)
        .addMapping(src -> src.getId(), Goal::setId)
        .addMapping(src -> src.getName(), Goal::setName)
        .addMapping(src -> src.getParams(), Goal::setParams);

        mapper.typeMap(GoalParamDto.class, GoalParam.class)
        .addMapping(src -> src.getId(), GoalParam::setId)
        .addMapping(src -> src.getName(), GoalParam::setName)
        .addMapping(src -> src.getApplicable(), GoalParam::setApply);

        // Template Mappings
		mapper.typeMap(Template.class, TemplateDto.class)
		.addMapping(src -> src.getTemplateHeaders(), TemplateDto::setHeaders)
		.addMapping(src -> src.getUpdatedBy(), (dest, value) -> dest.getUpdatedBy().setEmployeeId(1));

		mapper.typeMap(TemplateHeader.class, TemplateHeaderDto.class)
		.addMapping(src -> src.getGoal().getId(), TemplateHeaderDto::setGoalId)
		.addMapping(src -> src.getGoal().getName(), TemplateHeaderDto::setGoalName)
		.addMapping(src -> src.getTemplateDetails(), TemplateHeaderDto::setDetails);

		mapper.typeMap(TemplateDetail.class, TemplateDetailDto.class)
		.addMapping(src -> src.getGoalParam().getId(), TemplateDetailDto::setParamId)
		.addMapping(src -> src.getGoalParam().getName(), TemplateDetailDto::setParamName);

		mapper.typeMap(TemplateDto.class, Template.class)
		.addMapping(src -> src.getHeaders(), Template::setTemplateHeaders)
		.addMapping(src -> src.getUpdatedBy().getEmployeeId(), Template::setUpdatedBy)
		;

		mapper.typeMap(TemplateHeaderDto.class, TemplateHeader.class)
		.addMapping(src -> src.getGoalId(), (dest, value) -> dest.getGoal().setId((Long) value))
		.addMapping(src -> src.getGoalName(), (dest, value) -> dest.getGoal().setName((String) value))
		.addMapping(src -> src.getDetails(), TemplateHeader::setTemplateDetails);

		mapper.typeMap(TemplateDetailDto.class, TemplateDetail.class)
		.addMapping(src -> src.getParamId(), (dest, value) -> dest.getGoalParam().setId((Long) value))
		.addMapping(src -> src.getParamName(), (dest, value) -> dest.getGoalParam().setName((String) value));

		mapper.typeMap(GoalDto.class, TemplateHeaderDto.class)
		.addMappings(m -> m.skip(TemplateHeaderDto::setId))
		.addMapping(src -> src.getId(), TemplateHeaderDto::setGoalId)
		.addMapping(src -> src.getName(), TemplateHeaderDto::setGoalName)
		.addMapping(src -> src.getParams(), TemplateHeaderDto::setDetails);

		mapper.typeMap(GoalParamDto.class, TemplateDetailDto.class)
		.addMappings(m -> m.skip(TemplateDetailDto::setId))
		.addMapping(src -> src.getId(), TemplateDetailDto::setParamId)
		.addMapping(src -> src.getName(), TemplateDetailDto::setParamName)
		.addMapping(src -> src.getApplicable(), TemplateDetailDto::setApply);

		// Assignment Mappings
		mapper.typeMap(PhaseAssignment.class, EmployeeAssignmentDto.class)
        .addMapping(src -> src.getId(), EmployeeAssignmentDto::setAssignmentId)
        .addMapping(src -> src.getEmployeeId(), (dest, value) -> dest.getAssignedTo().setEmployeeId(1))
        .addMapping(src -> src.getAssignedBy(), (dest, value) -> dest.getAssignedBy().setEmployeeId(1))
        .addMapping(src -> src.getAssignedAt(), EmployeeAssignmentDto::setAssignedAt)
        .addMapping(src -> src.getStatus(), EmployeeAssignmentDto::setStatus);
        //.addMapping(src -> src.getScore(), EmployeeAssignmentDto::setScore)

		mapper.typeMap(CycleAssignment.class, EmployeeAssignmentDto.class)
        .addMapping(src -> src.getId(), EmployeeAssignmentDto::setAssignmentId)
        .addMapping(src -> src.getEmployeeId(), (dest, value) -> dest.getAssignedTo().setEmployeeId(1))
        .addMapping(src -> src.getAssignedBy(), (dest, value) -> dest.getAssignedBy().setEmployeeId(1))
        .addMapping(src -> src.getAssignedAt(), EmployeeAssignmentDto::setAssignedAt)
        .addMapping(src -> src.getStatus(), EmployeeAssignmentDto::setStatus);

		// Assessment Mappings
		mapper.typeMap(AssessHeader.class, AssessHeaderDto.class)
        .addMapping(src -> src.getId(), AssessHeaderDto::setId)
        .addMapping(src -> src.getAssignId(), AssessHeaderDto::setAssignId)
        .addMapping(src -> src.getAssessDate(), AssessHeaderDto::setAssessDate)
        .addMapping(src -> src.getAssessedBy(), AssessHeaderDto::setAssessedBy)
        .addMapping(src -> src.getStatus(), AssessHeaderDto::setStatus)
        .addMapping(src -> src.getAssessDetails(), AssessHeaderDto::setAssessDetails);

		mapper.typeMap(AssessHeaderDto.class, AssessHeader.class)
        .addMapping(src -> src.getId(), AssessHeader::setId)
        .addMapping(src -> src.getAssignId(), AssessHeader::setAssignId)
        .addMapping(src -> src.getAssessDate(), AssessHeader::setAssessDate)
        .addMapping(src -> src.getAssessedBy(), AssessHeader::setAssessedBy)
        .addMapping(src -> src.getStatus(), AssessHeader::setStatus)
        .addMapping(src -> src.getAssessDetails(), AssessHeader::setAssessDetails);

		mapper.typeMap(AssessDetail.class, AssessDetailDto.class)
        .addMapping(src -> src.getId(), AssessDetailDto::setId)
        .addMapping(src -> src.getTemplateHeaderId(), AssessDetailDto::setTemplateHeaderId)
        .addMapping(src -> src.getRating(), AssessDetailDto::setRating)
        .addMapping(src -> src.getScore(), AssessDetailDto::setScore)
        .addMapping(src -> src.getComments(), AssessDetailDto::setComments);

		mapper.typeMap(AssessDetailDto.class, AssessDetail.class)
        .addMapping(src -> src.getId(), AssessDetail::setId)
        .addMapping(src -> src.getTemplateHeaderId(), AssessDetail::setTemplateHeaderId)
        .addMapping(src -> src.getRating(), AssessDetail::setRating)
        .addMapping(src -> src.getScore(), AssessDetail::setScore)
        .addMapping(src -> src.getComments(), AssessDetail::setComments);

		mapper.typeMap(Employee.class, EmployeeDto.class);
		//.addMapping(src -> src.getFirstName() + " " + src.getLastName(), EmployeeDto::setFullName);

		mapper.typeMap(Employee.class, User.class)
        .addMapping(src -> src.getBand(), User::setBand)
        .addMapping(src -> src.getDesignation(), User::setDesignation)
        .addMapping(src -> src.getEmployeeId(), User::setEmployeeId)
        .addMapping(src -> src.getFirstName(), User::setFirstName)
        .addMapping(src -> src.getHiredOn(), User::setJoinedDate)
        .addMapping(src -> src.getLastName(), User::setLastName)
        .addMapping(src -> src.getLocation(), User::setLocation)
        .addMapping(src -> src.getLoginId(), User::setUsername)
        //.addMapping(src -> get(src.getEmployeeId()), User::setImageUrl)
        ;

		return mapper;
	}

	/*private Object get(Integer employeeId) {
		return "https://opera.softvision.com/Content/Core/img/Profile/" + employeeId + ".jpg";
	}*/

	/*@Bean
	public MapperFacade getOrikaBeanMapper() {
		MapperFactory mapperFactory = new DefaultMapperFactory.Builder().build();
		mapperFactory.classMap(AppraisalCycle.class, AppraisalCycleDto.class);
		mapperFactory.classMap(AppraisalCycleDto.class, AppraisalCycle.class);
		MapperFacade mapper = mapperFactory.getMapperFacade();
		return mapper;
	}*/
}
