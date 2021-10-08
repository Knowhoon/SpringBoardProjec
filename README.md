# SpringBoardProject
![image](https://user-images.githubusercontent.com/73919581/134300852-1f9798b4-777f-4f45-86e5-98624bdf9178.png)

***
안다훈
contact : knowhoon@gmail.com
***
 ## 기능 추가 보완 내역
  - 21.10.06 댓글 추천 기능 업데이트(댓글 중복 추천 방지 기능 포함)
  - 21.10.06 카카오 API 관련 카카오 토큰값 로그아웃 기능
  - 21.10.08 비밀번호 암호화시 salt 생성하여 회원가입 및 로그인 연동
***
#### 1. 프로젝트소개
- 1.1 프로젝트 목적
- 1.2 개발환경
- 1.3 프로젝트 기능

#### 2.프로젝트 구조 및 설정
- 2.1 프로젝트 구조
- 2.2 Spring 설정파일 구성

#### 3. 화면별 주요기능
 - 3. 주요기능 소개

#### 4. 프로젝트 후기
- 4.1 느낀점
- 4.2 프로젝트 보완점

## 1. 프로젝트 소개
 웹 프로그래밍의 기본 소양이라 할 수 있는 기본적인 기능인 CRUD가 가능한 게시판을 목적으로 교육을 수강 하며 기능들을 추가하여 제작한 프로젝트입니다.

#### 1.1 프로젝트 목적
 - 교육 수강중에 배운 내용을 기반으로 커뮤니티 구현에 대한 이해도를 높이고 추가적인 기능을 넣어 조금 더 높은 완성도를 가진 프로젝트를 구현해보고자 하였습니다.
 - 반복된 연습으로 빠르고 최적화된 게시판 생성을 목표로하였습니다. 가장큰 이유는 취업을 위한 준비과정입니다.
 - 코딩 감각과 스스로 공부하는 습관을 잃지 않기 위해 프로젝트에 새로운 기능을 적용하면서 경험을 축적하고있습니다.
#### 1.2 개발 환경
 - OS : window10
 - Develop Tool : spring-tool-suite-3.9.17(Spring Framework 4.3.2.RELEASE)
 - Data Base : MariaDB(10.5.10)
 - Language : Java, JavaScript, Ajax
 - Java Version : Java SE - 11
 - Web Application Server : Apache Tomcat-9.0.52

#### 1.3 프로젝트 기능

 초기에는 기본적인 CRUD 기능(Create, Read, Update, Delete가 가능한 게시판을 작성하고자 하였습니다.
 게시판을 작성하며 아쉬운 부분이 계속 생기면서 그동안 인터넷 게시판, 카페등에서 접했던 기능들을 추가하게 되었습니다.

 - 초기 기능
   - 게시물 작성, 게시물 조회, 게시물, 게시물 수정, 게시물 삭제, 게시글 댓글 작성, 게시글 댓글 수정, 게시글 댓글 삭제

 -  추가 기능
   - 웹 페이 이용자 분리(관리자, 회원, 비회원) - 분류된 사용자들에게 제한된 기능 제공
     Admin(회원 관리, 로그 확인, 게시판 노출 여부 설정, 게시판 이름 수정, 게시판 추가)
   - 게시글 페이징 기능, 게시글 추천(좋아요, 싫어요) 기능, 주간 베스트 게시글, 게시판별 베스트 게시글, 댓글 추천, 로그 검색, 게시물 검색 기능(제목,내용,제목+내용)
   - 회원가입시 JavaSript 정규식및 ajax 활용 아이디, 이메일 중복체크, 이메일 인증 구현
   - 카카오 로그인 기능 구현
   -

#### 2. 프로젝트 구조 및 설정(Spring Framework)

#### 2.1 프로젝트 구조
Database 구조(ERD)
 ![image](https://user-images.githubusercontent.com/73919581/134310066-ee7e5f63-eebd-435e-9795-954a59ecc3dd.png)
 - view를 활용하여 설계 - 보안성, 편의성

 ![image](https://user-images.githubusercontent.com/73919581/134317539-68001a66-d518-422f-b7a3-1e123bd5c6f4.png)
 패키지 구조

#### 2.1 Spring MVC 처리과정

- 2.2.1 클라이언트가 서버에 요청 -> 스프링에서 제공하는 DispatcherServlet이라는 Front-Controller가 요청을 가로챈다(web.xml)
- 2.2.2 요청을 가로챈 DispatcherServlet은 HandlerMapping에게 어떤 컨트롤러에거 요청을 위임할지 물어본다(servlet-context.xml)에서 @Controller로 등록한 것들을 스캔)
- 2.2.3 요청에 Mapping된 컨트롤러가 있다면 @Mapping을 통하여 요청을 처리할 Method로 전달한다.
- 2.2.4 컨트롤러에서는 해당 요청을 처리할 서비스를 주입 받아 비지니스 로직을 서비스에 위임한다.
- 2.2.5 서비스는 요청에 필요한 작업을 대부분 담당하여 DB접근이 필요하면 DAO를 주입받아 DB처리는 DAO에게 위임한다.
- 2.2.6 DAO는 Mybatis 설정을 이용해서 SQL쿼리문을 날려 DB의 정보를 받아 다시 서비스로 전달  한다.(DTO를 컨트롤러에서부터 내려받아 쿼리결과를 DTO에 담는다.)
- 2.2.7 모든 로직을 끝낸 서비스가 결과를 컨트롤러에게 리턴한다.
- 2.2.8 결과를 받은 커트롤러는 Model객체에 결과물을ㄹ 어떤 View에 보여줄 것인지 정보를 담아 DispatcherServlet으로 보낸다.
- 2.2.9 DispatcherServlet은 ViewResolver에게 받은 View에 대한 정보를 넘긴다.
- 2.2.10 ViewResolver는 해당 JSP를 찾아서 DispatcherServlet에게 알려준다.
- 2.2.11 DispatcherServlet은 응답할 View에게 Render를 지시하고 View는 응답 로직을 처리한다.
- 2.2.12 DispatcherServlet이 클라이언트에게 렌더링된 View를 응답한다.

#### 2.3 Spring 설정파일 구성

 - 2.3.1 web.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee https://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">

	<welcome-file-list>
		<wlecome-file>/</wlecome-file>
	</welcome-file-list>

	<session-config>
		<session.timeout>60</session.timeout>
	</session-config>

	<!-- The definition of the Root Spring Container shared by all Servlets and Filters -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/root-context.xml</param-value>
	</context-param>

	<!-- Creates the Spring Container shared by all Servlets and Filters -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>

	<!-- Processes application requests -->
	<servlet>
		<servlet-name>appServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<servlet-mapping>
		<servlet-name>appServlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>

	<filter>
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>
```

 - 2.3.2 servlet-context.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<beans:beans xmlns="http://www.springframework.org/schema/mvc"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:beans="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd
		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">

	<!-- DispatcherServlet Context: defines this servlet's request-processing infrastructure -->

	<!-- Enables the Spring MVC @Controller programming model -->
	<annotation-driven />

	<!-- Handles HTTP GET requests for /resources/** by efficiently serving up static resources in the ${webappRoot}/resources directory -->
	<resources mapping="/resources/**" location="/resources/"/>
	<resources mapping="/css/**" location="/resources/css/" />
	<resources mapping="/img/**" location="/resources/img/" />
	<resources mapping="/js/**" location="/resources/js/" />
	<resources mapping="/upfile/**" location="/resources/upfile/" />
	<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
	<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<beans:property name="prefix" value="/WEB-INF/views/" />
		<beans:property name="suffix" value=".jsp" />
	</beans:bean>

	<context:component-scan base-package="com.knowhoon.web" />
	<context:component-scan base-package="com.knowhoon.util" />

	<beans:import resource="classpath:/spring/**/*-context.xml"/>

</beans:beans>
```

 - 2.3.3 root-context.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd">

	<!-- Root Context: defines shared resources visible to all other web components -->
	<!-- For Pagination Tag -->
	<bean id="imageRenderer"
		class="com.knowhoon.util.ImagePaginationRenderer" />

	<bean id="textRenderer"
		class="egovframework.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationRenderer" />

	<bean id="paginationManager"
		class="egovframework.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationManager">
		<property name="rendererType">
			<map>
				<entry key="image" value-ref="imageRenderer" />
				<entry key="text" value-ref="textRenderer" />
			</map>
		</property>
	</bean>
	<!-- gmail설정 -->
	<bean id="mailSender2"
		class="org.springframework.mail.javamail.JavaMailSenderImpl">
		<property name="host" value="smtp.gmail.com" />
		<property name="port" value="587" />
		<property name="username" value="ID" /> <!-- 자신의 이메일 아이디 -->
		<property name="password" value="PW" /> <!-- 자신의 비밀번호 -->
		<!-- 보안연결 TLS과 관련된 설정 -->
		<property name="javaMailProperties">
			<props>
				<prop key="mail.smtp.starttls.enable">true</prop>
                <prop key="mail.smtp.auth">true    </prop>
                <prop key="mail.transport.protocol">smtp</prop>
                <prop key="mail.debug">true</prop>
                <prop key="mail.smtp.ssl.trust">smtp.gmail.com</prop>
                <prop key="mail.smtp.ssl.protocols">TLSv1.2</prop>
			</props>
		</property>
	</bean>

</beans>

```
 - 2.3.4 data-context.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="username" value="ID"/>
		<property name="password" value="PW"/>
		<property name="url" value="jdbc:mariadb://localhost:8080/knowhoon"/>
		<property name="driverClassName" value="org.mariadb.jdbc.Driver"/>
	</bean>

	<!-- sqlSessionFactory -->
	<bean id="sqlSessionFactoryBean" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"/>
		<property name="mapperLocations" value="classpath:/mybatis/mappers/*Mapper.xml"/>
		<property name="configLocation" value="classpath:/mybatis/config/mybatisConfig.xml"/>

	</bean>

	<!-- sqlSessionTemplate -->
	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
		<constructor-arg name="sqlSessionFactory" ref="sqlSessionFactoryBean"></constructor-arg>
	</bean>

</beans>
```
 - 2.3.5 file-context.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean class="org.springframework.web.multipart.commons.CommonsMultipartResolver" id="multipartResolver">
		<property name="defaultEncoding" value="UTF-8"></property>
		<!-- 파일 하나당 크기 50MB = 52428800byte -->
		<property name="maxUploadSizePerFile" value="52428800"></property>
		<!-- 전체 파일 허용 : byte -->
		<property name="maxUploadSize" value="104857600"></property>
	</bean>

</beans>
```

 - 2.3.6 mybatisConfig.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<!-- configuration 선언 -->
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<typeAliases>
		<typeAlias type="java.lang.Integer" alias="integer"/>
		<typeAlias type="com.knowhoon.web.board.BoardDTO" alias="BoardDTO"/>
		<typeAlias type="com.knowhoon.web.board.VoteDTO" alias="VoteDTO"/>
		<typeAlias type="com.knowhoon.web.comment.CommentDTO" alias="CommentDTO"/>
		<typeAlias type="com.knowhoon.web.login.LoginDTO" alias="LoginDTO"/>
		<typeAlias type="com.knowhoon.web.admin.AdminDTO" alias="AdminDTO"/>
		<typeAlias type="com.knowhoon.web.log.LogDTO" alias="LogDTO"/>
		<!-- 내가 만든 클래스를 mybatis가 사용할 수 있도록 등록해주기 -->
	</typeAliases>
</configuration>
```

#### 3. 화면 별 주요 기능

공통 기능 및 기술
- header, menu, footer 등 모든 페이지에 공통으로 삽입되는 코드 import하여 중복코드 제거
- JavaScript를 이용하여 유효성 검사 - Ajax활용하여 중복 가입 방지(아이디, 이메일)

#### 3.1 Main Page

![image](https://user-images.githubusercontent.com/73919581/134325832-281f4b8b-2dcd-463a-9a56-ca4c46b5bc2c.png)

#### 3.2 Login Page

![image](https://user-images.githubusercontent.com/73919581/134337065-d226df52-6bfc-421d-8076-34ddadbf33ce.png)

#### 3.3 Join Page

![image](https://user-images.githubusercontent.com/73919581/134328775-d1935fbc-9d76-488b-af9e-62160140ce23.png)
![image](https://user-images.githubusercontent.com/73919581/134329361-188ff1c2-ea5c-403d-9994-9e2f0fd15a06.png)
![image](https://user-images.githubusercontent.com/73919581/134351840-780df56d-c912-4d16-9291-6eee8d7983bd.png)

#### 3.4 board Page

## 3.4.1 board.jsp

![image](https://user-images.githubusercontent.com/73919581/134339326-67111a7d-a8d5-4110-8cc1-5e364eb4a0c8.png)

## 3.4.2 detail.jsp

![image](https://user-images.githubusercontent.com/73919581/134333417-1384d772-7f5b-49a2-915a-d59a13691acb.png)
![image](https://user-images.githubusercontent.com/73919581/134333908-20d7cc21-ac42-4ab0-ab18-5515f9f235f7.png)

## 3.4.3 write.jsp

![image](https://user-images.githubusercontent.com/73919581/134336724-9ce5fe4a-cf83-4bdb-9b7b-56cfb5d12c4c.png)

### 3.5 Admin Page

## 3.5.1 memberList.jsp

![image](https://user-images.githubusercontent.com/73919581/134337597-395d683a-dd24-4e03-afc0-531979d8fc2a.png)

## 3.5.2 logList.jsp

![image](https://user-images.githubusercontent.com/73919581/134338187-dce99a74-472b-4a71-a5a3-0a9323e2f713.png)

## 3.5.3 category

![image](https://user-images.githubusercontent.com/73919581/134338658-16e088ad-cac2-4687-8e9c-f24d0d065f3e.png)

#### 4. 프로젝트 후기

## 4.1 느낀점

이번 SpringBoard 프로젝트를 하며서 느낀점은 Mybatis 기능을 새롭게 배워 프로젝트 진행한 결과 개발속도가 2배 이상 빨라진 것 같습니다.
Mybatis로 동적 SQL을 쉽게 작성하게 되어 불필요한 중복 코드들을 줄일 수 있고 어렵게 생각했던 기능들을 쉽게 구현해 볼 수 있었습니다.
추천기능등 페이지 이동이 필요없는 기능을 Ajax를 이용하여 리팩토링 하여 댓글 작성, 수정, 삭제, 추천 등을 할 때 페이지가 다시 로딩되는 문제를 해결 예정입니다.

## 4.2 프로젝트 보완점

 - 댓글 추천 기능 ------21.10.06 완료
 - 비밀번호 암호화시 salt 생성하여 회원가입 및 로그인 연동 ------21.10.08 완료
 - 보안 관련 라이브러리 추가하여 XSS취약점 보완
 - 실시간 쪽지 기능(Socket) - 댓글 알림 추천 알림 등
 - 회원 정보 조회 기능(작성 게시물 조회, 작성 댓글 조회)
 - Admin 전체 글 조회, 삭제 기능
