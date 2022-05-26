package kr.human.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.vo.EmpVO;

public class EmpDAO {
	private static EmpDAO instance = new EmpDAO();
	private EmpDAO() {	}
	public static EmpDAO getInstance() {return instance;}
	//=================================================================================
	
	public List<EmpVO> selectAll(SqlSession sqlSession){
		return sqlSession.selectList("emp.selectAll");
	}
	public List<EmpVO> selectDept(SqlSession sqlSession, String deptno){
		return sqlSession.selectList("emp.selectDept", deptno);
	}
	public List<EmpVO> selectList(SqlSession sqlSession, String deptno){
		return sqlSession.selectList("emp.selectList", deptno);
	}
	
}
