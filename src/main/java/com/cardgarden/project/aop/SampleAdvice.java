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

    // ���ϴ� Ÿ�� ��Ű��/���������� �����ؼ� ���
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
		/* �ְ��ɻ縦 ���� �� */
    	log.info("[SampleAdvice] Around - before: {}", jp.getSignature().toShortString());
    	
    	
		//------------------------------------------------------------
		/* �ְ��ɻ翡 ���� */
    	Object result = jp.proceed();
		//------------------------------------------------------------
		/* �ְ��ɻ縦 �ٳ�� �� */
    	log.info("[SampleAdvice] Around - after: {}", jp.getSignature().toShortString());
    	
    	
		//============================================================		
    	return result;
    }
}
