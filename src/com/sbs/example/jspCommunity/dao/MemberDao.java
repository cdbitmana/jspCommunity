package com.sbs.example.jspCommunity.dao;

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

		for (Map<String, Object> memberMap : memberMapList) {
			members.add(new Member(memberMap));
		}

		return members;
	}

}
