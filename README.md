import Java.util.Scanner;

class myClass{

   public static void main(String[]args){
 
     Scanner myobj=new Scanner(System.in);

    System.out.println("Enter your username");

String username= myobj.nextLine();
//nextline method is used since it reads the whole line completely 

System.out.println("username is:"+username);
}
}
