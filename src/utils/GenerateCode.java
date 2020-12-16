package utils;

import java.util.Random;

public class GenerateCode {
    private static final String[] letter={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
            "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
    private static final String[] num={"1","2","3","4","5","6","7","8","9","0"};
    public static void main(String[] args) throws InterruptedException {
        System.out.println(GenerateSixBitCode());
    }
    public static StringBuilder GenerateSixBitCode() throws InterruptedException {
        StringBuilder sixBitCode= new StringBuilder();
        for(int i=0;i<6;i++){
            Random random1=new Random(System.currentTimeMillis());
            //Step 1:生成随机数，确定随机码是数字还是字母，0，1为字母，2为数字
            int choice1=random1.nextInt(10000000)%3;
            if(choice1==0||choice1==1){
                Random random2=new Random(System.currentTimeMillis());
                int choice2=random2.nextInt(10000000)%52;
                sixBitCode.append(letter[choice2]);
            }else{
                Random random2=new Random(System.currentTimeMillis());
                int choice3=random2.nextInt(10000000)%10;
                sixBitCode.append(num[choice3]);
            }
            Thread.sleep(1);
        }
        return sixBitCode;


    }
}
