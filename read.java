import java.util.List;
import java.io.FileReader;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileNotFoundException;

public class read{
    //gets average of list
    public static Double average(List<Integer> lst){
        Double sum = 0.0;
        for (int i : lst){
            Double cur=(double) i;
            sum+=cur;
        }
        return (sum/lst.size());
    }

    //gets winning player from team
    public static Integer parseWinner(String str){
        switch(str){
            case "p1": return 1;
            case "p2": return 2;
            default: 
                System.out.println("WARNING: tie present");
                return 0;
        }
    }

    public static void main(String[] args){

        //wins per # of aces
        Double a0Wins = 0.0;
        Double a1Wins = 0.0;
        Double a2Wins = 0.0;
        Double a3Wins = 0.0;
        Double a4Wins = 0.0;

        //size of war
        String size = "";

        //read file
        try (BufferedReader br = new BufferedReader(new FileReader("data.csv"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");

                //debug csv parsing
                if(!values[0].equals(size))System.out.println("new:" + values[0] + "  old:" + size);
                size=values[0];

                //update win counters based on game data
                int index=parseWinner(values[3]);
                switch(Integer.valueOf(values[index])){
                    case 0:a0Wins++; break;
                    case 1:a1Wins++; break;
                    case 2:a2Wins++; break;
                    case 3:a3Wins++; break;
                    case 4:a4Wins++; break;
                }
            }

            //# of games for each # of aces
            Double num0s = a0Wins+a4Wins;
            Double num1s = a1Wins+a3Wins;
            Double num3s = num1s;
            Double num4s = num0s;

            //percentages of wins per ace
            String avg0 = Double.toString((a0Wins/num0s)*100)+"%";
            String avg1 = Double.toString((a1Wins/num1s)*100)+"%";
            String avg3 = Double.toString((a3Wins/num3s)*100)+"%";
            String avg4 = Double.toString((a4Wins/num4s)*100)+"%";

            //print analysis
            System.out.println("War size: " + size);
            System.out.println(Double.toString(a0Wins) + " games were won with 0 aces; win rate: " + avg0);
            System.out.println(Double.toString(a1Wins) + " games were won with 1 ace; win rate:  " + avg1);
            System.out.println(Double.toString(a2Wins) + " games were won with 2 aces. All games played by someone with two aces are won by someone with two aces.");
            System.out.println(Double.toString(a3Wins) + " games were won with 3 aces; win rate: " + avg3);
            System.out.println(Double.toString(a4Wins) + " games were won with 4 aces; win rate: " + avg4);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
