@isTest
public with sharing class QAClassTest {
	static testMethod void prueba(){
   		Test.startTest();
        QAClass.QAClassMethod();
        Test.stopTest();
	}	
}