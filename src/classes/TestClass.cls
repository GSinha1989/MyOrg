@isTest
private class TestClass {
    //Testing the stack class Method 
    //PUSH(sObject) - Inserts the Data in the Stack
    //POP()- Remove the first data from the Stack
    //size()- Returns the length of stack
    //isEmpty()- Return if the stack is empty or not
    //
     @isTest static  void StackClassTest(){
        Stack st = new Stack();
        Account a = new Account(name='good');
        st.push(a);
         a = new Account(name='bad');
         st.push(a);
         a = new Account(name='ugly');
         st.push(a);
         a = new Account(name='nota');
         st.push(a);
         System.assert(st.size()==4);
         System.assert(st.isEmpty()==false);
         System.assert(((Account)st.pop()).name=='good', 'Success');
         System.assert(((Account)st.pop()).name=='bad', 'Success');
         System.assert(((Account)st.pop()).name=='ugly', 'Success');
    	st.traverse();
     }

}