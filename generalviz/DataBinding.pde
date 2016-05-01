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
    ArrayList<Float> x_sort_data = new ArrayList<Float>();
    ArrayList<Float> y_sort_data = new ArrayList<Float>();
    ArrayList<Float> z_sort_data = new ArrayList<Float>();


    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      x_sort_data.add(row.getFloat(data_binding_schema.get("size")));
      y_sort_data.add(row.getFloat(data_binding_schema.get("size")));
      z_sort_data.add(row.getFloat(data_binding_schema.get("size")));

    }

    Float[] x_sort = x_sort_data.toArray(new Float[x_sort_data.size()]);
    ArrayIndexComparator x_comparator = new ArrayIndexComparator(x_sort);
    Integer[] x_indexes = x_comparator.createIndexArray();
    Arrays.sort(x_indexes, x_comparator);
    
    Float[] y_sort = y_sort_data.toArray(new Float[y_sort_data.size()]);
    ArrayIndexComparator y_comparator = new ArrayIndexComparator(y_sort);
    Integer[] y_indexes = y_comparator.createIndexArray();
    Arrays.sort(y_indexes, y_comparator);
    
    Float[] z_sort = z_sort_data.toArray(new Float[z_sort_data.size()]);
    ArrayIndexComparator z_comparator = new ArrayIndexComparator(z_sort);
    Integer[] z_indexes = z_comparator.createIndexArray();
    Arrays.sort(z_indexes, z_comparator);

    PVector[] locations = new PVector[x_indexes.length];
    
    for (int i = 0; i < locations.length; i++) {
      locations[i] = new PVector(0, 0, 0);
    }
    
    PVector x_offset = new PVector(30, 0, 0);
    PVector y_offset = new PVector(0, 30, 0);
    PVector z_offset = new PVector(0, 0, 30);

    for (int i = 0; i < locations.length; i++) {
      PVector x_old = locations[x_indexes[i]].get();
      locations[x_indexes[i]] = PVector.add(x_old, PVector.mult(x_offset, i));
    }
    
    for (int i = 0; i < locations.length; i++) {
      PVector y_old = locations[y_indexes[i]].get();
      locations[y_indexes[i]] = PVector.add(y_old, PVector.mult(y_offset, i));
    }
    
    for (int i = 0; i < locations.length; i++) {
      PVector z_old = locations[z_indexes[i]].get();
      locations[z_indexes[i]] = PVector.add(z_old, PVector.mult(z_offset, i));
    }

    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);

      color rand_color = color(random(255), random(255), random(255));

      int primitive_size = row.getInt(data_binding_schema.get("size"));

      int primitive_type = int(data_binding_schema.get("primitive_type"));

      PrimitiveFactory pf = new PrimitiveFactory(primitive_type);
      Primitive p = pf.get();

      p.setSize(primitive_size);
      
      p.setSoundFilename("data/song.wav");
      p.initializeSound();
      
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

