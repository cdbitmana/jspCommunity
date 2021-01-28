package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.dto.Member;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

public class MemberDao {

	public List<Member> getForPrintMembers() {
		List<Member> members = null;

		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `member`");

		List<Map<String, Object>> memberMapList = MysqlUtil.selectRows(sql);

		if(!memberMapList.isEmpty()) {
			members = new ArrayList<>();
			for (Map<String, Object> memberMap : memberMapList) {
				members.add(new Member(memberMap));
			}	
		}
		

		return members;
	}

	public Member getMemberByLoginId(String loginId) {

		Member member = null;
		
		SecSql sql = new SecSql();
		
		sql.append("SELECT * FROM `member`");
		sql.append("WHERE loginId = ?", loginId);
		
		Map<String,Object> memberMap = MysqlUtil.selectRow(sql);
		
		if(!memberMap.isEmpty()) {
			member = new Member(memberMap);
		}
		
		return member;
	}

	public int doJoin(String loginId, String loginPw, String name, String nickName, String email, String phoneNo) {
		
		SecSql sql = new SecSql();
		
		sql.append("INSERT INTO `member` SET");
		sql.append("regDate = NOW() , updateDate = NOW() ,");
		sql.append("loginId = ?,",loginId);
		sql.append("loginPw = ?,",loginPw);
		sql.append("name = ?,",name);
		sql.append("nickName = ?,",nickName);
		sql.append("email = ?," , email);
		sql.append("phoneNo = ?," , phoneNo);
		sql.append("authLevel = 1");
		
		return MysqlUtil.insert(sql);
	}

	public Member getMemberByName(String name) {
		
		Member member = null;
		
		SecSql sql = new SecSql();
		
		sql.append("SELECT * FROM `member`");
		sql.append("WHERE `name` = ?", name);
		
		Map<String,Object> memberMap = MysqlUtil.selectRow(sql);
		
		if(!memberMap.isEmpty()) {
			member = new Member(memberMap);
		}
		return member;
	}

	public Member getMemberById(int id) {
		Member member = null;
		
		SecSql sql = new SecSql();
		
		sql.append("SELECT * FROM `member`");
		sql.append("WHERE id = ?", id);
		
		Map<String,Object> memberMap = MysqlUtil.selectRow(sql);
		
		if(!memberMap.isEmpty()) {
			member = new Member(memberMap);
		}
		
		return member;
	}

	public int modify(Map<String, Object> args) {
		SecSql sql = new SecSql();
		sql.append("UPDATE member");
		sql.append("SET updateDate = NOW()");

		boolean needToUpdate = false;

		if (args.get("loginPw") != null) {
			needToUpdate = true;
			sql.append(", loginPw = ?", args.get("loginPw"));
		}
		

		if (args.get("name") != null) {
			needToUpdate = true;
			sql.append(", `name` = ?", args.get("name"));
		}

		if (args.get("nickName") != null) {
			needToUpdate = true;
			sql.append(", nickName = ?", args.get("nickName"));
		}

		if (args.get("email") != null) {
			needToUpdate = true;
			sql.append(", email = ?", args.get("email"));
		}

		if (args.get("phoneNo") != null) {
			needToUpdate = true;
			sql.append(", phoneNo = ?", args.get("phoneNo"));
		}

		if (args.get("authLevel") != null) {
			needToUpdate = true;
			sql.append(", authLevel = ?", args.get("authLevel"));
		}

		if ( needToUpdate == false ) {
			return 0;
		}

		sql.append("WHERE id = ?", args.get("id"));

		return MysqlUtil.update(sql);
	}

}
