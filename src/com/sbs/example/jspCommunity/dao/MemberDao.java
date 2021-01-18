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

	public int doJoin(String loginId, String loginPw, String name, String nickName) {
		
		SecSql sql = new SecSql();
		
		sql.append("INSERT INTO `member` SET");
		sql.append("regDate = NOW() , updateDate = NOW() ,");
		sql.append("loginId = ?,",loginId);
		sql.append("loginPw = ?,",loginPw);
		sql.append("name = ?,",name);
		sql.append("nickName = ?,",nickName);
		sql.append("authLevel = 1");
		
		return MysqlUtil.insert(sql);
	}

}
