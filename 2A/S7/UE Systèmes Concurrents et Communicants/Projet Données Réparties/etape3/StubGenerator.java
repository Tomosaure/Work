import java.io.*;
import java.lang.reflect.*;

public class StubGenerator {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java StubGenerator <interface> <output file>");
            System.exit(1);
        }
        String interfaceName = args[0];
        try {
            Class<?> interfaceClass = Class.forName(interfaceName);
            Method[] methods = interfaceClass.getDeclaredMethods();

            String stubMethods = "public class " + interfaceName + "_stub extends SharedObject implements "+ interfaceName + "_itf, java.io.Serializable {\n";
            Constructor<?>[] constructors = interfaceClass.getDeclaredConstructors();
            for (int i = 0; i < constructors.length; i++) {
              Constructor<?> constructor = constructors[i];
              String constructorName = constructor.getName();
              String stubConstructorName = constructorName;
              stubMethods += "  public" + " " + stubConstructorName + "_stub" +"(";
              stubMethods += "Object o, int id";
              stubMethods += ") {\n";
              stubMethods += "    super(o,id";
              stubMethods += ");\n  }\n";
          }
            for (int i = 0; i < methods.length; i++) {
                Method method = methods[i];
                Class<?>[] parameterTypes = method.getParameterTypes();
                Class<?> returnType = method.getReturnType();
                String methodName = method.getName();
                String stubMethodName = methodName;
                stubMethods += "  public " + returnType.getName() + " " + stubMethodName + "(";
                for (int j = 0; j < parameterTypes.length; j++) {
                    stubMethods += parameterTypes[j].getName() + " arg" + j;
                    if (j < parameterTypes.length - 1) {
                        stubMethods += ", ";
                    }
                }
                stubMethods += ") {\n";
                stubMethods += "    " + interfaceName + " s = (" + interfaceName + ")obj;\n";
                stubMethods += "    ";
                if (returnType.getName() != "void") {
                    stubMethods += "return ";
                }
                stubMethods +="s." + methodName + "(";
                for (int j = 0; j < parameterTypes.length; j++) {
                    stubMethods += "arg" + j;
                    if (j < parameterTypes.length - 1) {
                        stubMethods += ", ";
                    }
                }
                stubMethods += ");\n  }\n";
                
            }
            stubMethods += "}";

            File file = new File(interfaceName + "_stub.java");
            file.createNewFile();

            FileOutputStream fos = new FileOutputStream(file); 
            fos.write(stubMethods.getBytes());
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}