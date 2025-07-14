import Java.util.Scanner;

class myClass{

   public static void main(String[]arg){
 
     Scanner myobj=new Scanner(System.in);

    System.out.println("Enter your username");

String username= myobj.nextline();
//nextline method is used since it reads the whole line completely 

System.out.println("username is:"+username);
}
}
