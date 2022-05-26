package kr.human.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.dao.EmpDAO;
import kr.human.mybatis.MybatisApp;
import kr.human.vo.EmpVO;

public class EmpService {
	private static EmpService instance = new EmpService();
	private EmpService() {	}
	public static EmpService getInstance() {return instance;}
	//===============================================================================
	
	public List<EmpVO> selectAll(){
		List<EmpVO> list = null;
		EmpDAO dao = EmpDAO.getInstance();
		
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			//----------------------------------------------------------------
			//이 부분만 변경된다
			
			list = dao.selectAll(sqlSession);
			//----------------------------------------------------------------
			sqlSession.commit();
		}catch(Exception e){
			
			sqlSession.rollback();
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
		return list;
	}
	public List<EmpVO> selectDept(String deptno){
		List<EmpVO> list = null;
		EmpDAO dao = EmpDAO.getInstance();
		
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			//----------------------------------------------------------------
			//이 부분만 변경된다
			
			list = dao.selectDept(sqlSession, deptno);
			//----------------------------------------------------------------
			sqlSession.commit();
		}catch(Exception e){
			
			sqlSession.rollback();
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<EmpVO> selectList(String deptno){
		List<EmpVO> list = null;
		EmpDAO dao = EmpDAO.getInstance();
		
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			//----------------------------------------------------------------
			//이 부분만 변경된다
			
			list = dao.selectList(sqlSession, deptno);
			//----------------------------------------------------------------
			sqlSession.commit();
		}catch(Exception e){
			
			sqlSession.rollback();
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
		
		return list;
	}
	
}