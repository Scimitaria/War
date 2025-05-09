import java.util.List;
import java.util.ArrayList;
import java.io.FileReader;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileNotFoundException;

public class read{
    public static Double average(List<Integer> lst){
        Double sum = 0.0;
        for (int i : lst){
            Double cur=(double) i;
            sum+=cur;
        }
        return (sum/lst.size());
    }
    
    public static Integer parseWinner(String str){
        switch(str){
            case "p1": return 1;
            case "p2": return 2;
            default: return 0;
        }
    }
    public static void main(String[] args){
        List<Integer> warSize = new ArrayList<>();
        List<Integer> winners = new ArrayList<>();
        List<Integer> aces1   = new ArrayList<>();
        List<Integer> aces2   = new ArrayList<>();

        int p1Wins = 0;
        int p2Wins = 0;

        try (BufferedReader br = new BufferedReader(new FileReader("data.csv"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                warSize.add(Integer.parseInt(values[0]));
                aces1.add(Integer.parseInt(values[1]));
                aces2.add(Integer.parseInt(values[2]));
                winners.add(parseWinner(values[3]));
            }
            System.out.println(Double.valueOf(average(winners)));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
