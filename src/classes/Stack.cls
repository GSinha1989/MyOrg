public with sharing class Stack {

	Node First, Last;
	Integer length;
	public Stack(){
		length = 0;
		First = Last = Null;
	}
	
	public integer size(){
		return length;
	}
	
	public boolean isEmpty(){
		if(length > 0 )return false;
		else return true;
	}
	
	public void push(sObject value){
		Node temp = new Node();
		temp=new Node(null,value);
		if(length==0){
			First=Last=temp;	
		}else{
			Last.link= temp;
			Last = Last.link;
		}
		length++;
	}
	
	public sObject pop(){
		sObject o = null;
		if(length == 0){
			System.debug('unable to delete as stack is empty');
			return null;
		}if(length == 1){
			o = First.value;
			First=Last=null;
			length=0;
		}else{
			o = First.value;
			First=First.link;
			length--;
		}
		return o;
	}
	public void traverse(){
		Node temp = First;
		while(temp.link!=null){
			System.debug(temp.value);
		}
	}
	public class Node{
		Node link;
		sObject value;
		public Node(){
			link=null;
			value = null;
		}
		public  Node(Node link , sObject value){
			this.link = link;
			this.value = value;
		}
	}
	
	
}