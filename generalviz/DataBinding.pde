import java.util.*;

class InvalidDataBindingException extends Exception
{
  public InvalidDataBindingException (String message)
  {
    super(message);
  }
}

class DataBinding {
  // A DataBinding takes a DataHandler and a DataBindingSchema
  // and returns an ArrayList of Primitives.

  DataHandler data_handler;
  DataBindingSchema data_binding_schema;

  DataBinding(DataHandler data_handler_, DataBindingSchema data_binding_schema_) {
    data_handler = data_handler_;
    data_binding_schema = data_binding_schema_;

    try {
      this.validate();
    }
    catch (Exception exc) {
      exc.printStackTrace();
    }
  }

  PrimitiveGroup bind() {

    ArrayList<Primitive> primitives = new ArrayList<Primitive>();
    PrimitiveGroup primitive_group = new PrimitiveGroup();

    String fill_color_type = data_binding_schema.get("fill_color_type");
    HashMap color_map;

    if (fill_color_type.equals("quantitative")) {
      color_map = colorify_quantitative();
    } else {
      color_map = colorify_qualitative();
    }


    // Location sorting procedures


    ArrayList<Float> sort_data = new ArrayList<Float>();

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      sort_data.add(row.getFloat(data_binding_schema.get("size")));
    }

    Float[] countries = sort_data.toArray(new Float[sort_data.size()]);
    ArrayIndexComparator comparator = new ArrayIndexComparator(countries);
    Integer[] indexes = comparator.createIndexArray();
    Arrays.sort(indexes, comparator);
    println(indexes);

    PVector[] locations = new PVector[indexes.length];
    PVector offset = new PVector(10, 0, 0);
    PVector current = new PVector(0, 0, 0);

    for (int i = 0; i < indexes.length; i++) {
      locations[indexes[i]] = PVector.add(current, (PVector.mult(offset, i)));
    }

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      color rand_color = color(random(255), random(255), random(255));

      int primitive_size = row.getInt(data_binding_schema.get("size"));

      int primitive_type = int(data_binding_schema.get("primitive_type"));

      PrimitiveFactory pf = new PrimitiveFactory(primitive_type);
      Primitive p = pf.get();

      p.setSize(primitive_size);
      p.move_to(locations[i]);

      int fill_color;

      if (fill_color_type.equals("quantitative")) {
        fill_color = (Integer) color_map.get(row.getFloat(data_binding_schema.get("fill_color")));
      } else {
        fill_color = (Integer) color_map.get(row.getString(data_binding_schema.get("fill_color")));
      }

      p.setColor(fill_color);

      primitives.add(p);
    }

    primitive_group.populate(primitives);
    return primitive_group;
  }

  HashMap colorify_qualitative() {
    HashMap<String, Integer> color_map = new HashMap<String, Integer>();

    int track = 0;

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      String col_name = data_binding_schema.get("fill_color");
      String obs = row.getString(col_name);

      Palette p = new Palette(3);
      Integer[] pal = p.pal.toArray(new Integer[0]);

      if (color_map.containsKey(obs)) {
        // don't do anything
      } else {
        color_map.put(obs, pal[track]);
        track += 1;
      }
    }

    return color_map;
  }

  HashMap colorify_quantitative() {
    HashMap<Float, Integer> color_map = new HashMap<Float, Integer>();

    int track = 0;

    ArrayList<Float> observations = new ArrayList<Float>();

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      float obs = row.getFloat(data_binding_schema.get("fill_color"));
      observations.add(obs);
    }

    float obs_max = Collections.max(observations);
    float obs_min = Collections.min(observations);

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      float obs = row.getFloat(data_binding_schema.get("fill_color"));

      color LERP_FROM = color(255, 0, 0);
      color LERP_TO = color(0, 255, 255);

      if (color_map.containsKey(obs)) {
        // don't do anything
      } else {
        float obs_rescaled = map(obs, obs_min, obs_max, 0, 1);
        color_map.put(obs, lerpColor(LERP_FROM, LERP_TO, obs_rescaled));
      }
    }
    return color_map;
  }

  void validate() throws InvalidDataBindingException {
    String[] aesthetics = { 
      "size", "fill_color"
    };

    Set<String> column_titles = new HashSet<String>(Arrays.asList(data_handler.get_column_titles()));

    ArrayList<Boolean> tests = new ArrayList<Boolean>();    

    for (int i = 0; i < aesthetics.length; i++) {
      Boolean test = column_titles.contains(data_binding_schema.get(aesthetics[i]));
      tests.add(test);
    }

    if (tests.contains(false)) {
      throw new InvalidDataBindingException("Validation test failed.");
    }
  }
}

public class ArrayIndexComparator implements Comparator<Integer> {
  private final Float[] array;

  public ArrayIndexComparator(Float[] array)
  {
    this.array = array;
  }

  public Integer[] createIndexArray()
  {
    Integer[] indexes = new Integer[array.length];
    for (int i = 0; i < array.length; i++)
    {
      indexes[i] = i; // Autoboxing
    }
    return indexes;
  }

  @Override
    public int compare(Integer index1, Integer index2)
  {
    // Autounbox from Integer to int to use as array indexes
    return array[index1].compareTo(array[index2]);
  }
}

