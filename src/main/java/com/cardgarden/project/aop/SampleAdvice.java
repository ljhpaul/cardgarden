package com.cardgarden.project.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class SampleAdvice {

    // 원하는 타겟 패키지/계층명으로 수정해서 사용
//	@Pointcut("within(com.cardgarden.project.model.sample.SampleService)")
	@Pointcut("execution(* selectAll())")
    public void targetMethod() {}

    @Before("targetMethod()")
    public void before(JoinPoint jp) {
    	log.info("[SampleAdvice] Before: {}", jp.getSignature().toShortString());
    }

    @After("targetMethod()")
    public void after(JoinPoint jp) {
    	log.info("[SampleAdvice] After: {}", jp.getSignature().toShortString());
    }

    @Around("targetMethod()")
    public Object around(ProceedingJoinPoint jp) throws Throwable {
		//============================================================
		/* 주관심사를 가기 전 */
    	log.info("[SampleAdvice] Around - before: {}", jp.getSignature().toShortString());
    	
    	
		//------------------------------------------------------------
		/* 주관심사에 가기 */
    	Object result = jp.proceed();
		//------------------------------------------------------------
		/* 주관심사를 다녀온 후 */
    	log.info("[SampleAdvice] Around - after: {}", jp.getSignature().toShortString());
    	
    	
		//============================================================		
    	return result;
    }
}
