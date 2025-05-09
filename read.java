import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
import java.io.FileReader;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileNotFoundException;

public class read{
    public static void main(String[] args){
        List<Integer> warSize = new ArrayList<>();
        List<Integer> aces1   = new ArrayList<>();
        List<Integer> aces2   = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader("data.csv"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                warSize.add(Integer.parseInt(values[0]));
                aces1.add(Integer.parseInt(values[1]));
                aces2.add(Integer.parseInt(values[2]));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
