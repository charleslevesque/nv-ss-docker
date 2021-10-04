using System.Runtime.InteropServices;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

namespace NventiveSSDocker
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostingContext, config) =>
                {
                    var root = RuntimeInformation.IsOSPlatform(OSPlatform.Windows)
                        ? @"C:\" : "/";
                    var secretsPath = Path.Combine(root, "var", "secrets");

                    config.AddEnvironmentVariables(prefix: "NVSSDOCKER_");
                    config.AddKeyPerFile(secretsPath, optional: true, reloadOnChange: false);
                })
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<NventiveSSDocker.Startup>();
                });
    }
}
