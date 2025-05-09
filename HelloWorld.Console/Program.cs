var assemblyInfo = new AssemblyInfo();
var version = assemblyInfo.GetVersion();

Console.WriteLine($"Hello, World!");
Console.WriteLine($"Version: {version}");

public class AssemblyInfo
{
    public string GetVersion()
    {
        var version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version;
        if(version != null)
        {
            return $"{version.Major}.{version.Minor}.{version.Build}";
        }

        throw new InvalidOperationException("Version information is not available.");
    }
}