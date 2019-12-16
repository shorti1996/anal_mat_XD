package lista9;

import java.util.HashMap;

public class ConditionalProbabilityMap {
    private HashMap<Object, ProbabilityMap> map = new HashMap<>();

    public void increment(Object condition, Object value) {
        ProbabilityMap probabilityMap;
        if (map.containsKey(value)) {
            probabilityMap = map.get(value);
        } else {
            probabilityMap = new ProbabilityMap();
            map.put(value, probabilityMap);
        }
        probabilityMap.increment(condition);
    }

    public ProbabilityMap getProbabilityMap(Object value) {
        return map.get(value);
    }
}
