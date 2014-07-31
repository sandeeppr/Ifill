/**
 * 
 */
package com.ifill.userMgmt.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ifill.common.exceptions.DataAccessLayerException;
import com.ifill.common.utils.IfillConstants;
import com.ifill.userMgmt.vo.User;

/**
 * @author Sandy
 *
 */
@Service
public class ProfileMgmtDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private static String ROLES_ADMIN = "ADMIN";
	private static String ROLES_SUPERVISOR = "SUPERVISOR";
	
	private static String FIND_USER_BY_LOGIN_ID = "SELECT ename from users where login_id = ? AND password = ? AND role_id = ?";
	private static String CREATE_USER = "INSERT INTO users(emp_id, ename, dob, bloodgroup, role_id, status) VALUES(?,?,?,?,?,?)";
	private static String UPDATE_USER_CREDS = "UPDATE users SET login_id = ?, password = ? WHERE emp_id = ?";
	
	public String findUserByLoginId(String login, String password, boolean isAdmin){
		Map<String,Object> rows = null;
		try{
			rows = jdbcTemplate.queryForMap(FIND_USER_BY_LOGIN_ID, new Object[]{login,password, (isAdmin)? ROLES_ADMIN : ROLES_SUPERVISOR});
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		if(rows.isEmpty() || rows.size()>1){
			return null;
		}else{
			return rows.get(IfillConstants.CONSTANTS_ENAME).toString();
		}
	}
	
	public void createUser(User user){
		Object[] params = {user.getEmpId(), user.getName(), user.getDob(), user.getBloodgroup(), user.getUserId(), user.getPassword(), (user.isAdmin())? ROLES_ADMIN : ROLES_SUPERVISOR, user.isStatus()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.DATE, Types.VARCHAR, Types.VARCHAR, Types.BOOLEAN};
		try{
			jdbcTemplate.update(CREATE_USER, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
	public void createUserLoginCreds(User user){
		Object[] params = {user.getUserId(), user.getPassword(),user.getEmpId()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		try{
			jdbcTemplate.update(UPDATE_USER_CREDS, params, types);
		}catch(DataAccessException dae){
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
	}
	
}
