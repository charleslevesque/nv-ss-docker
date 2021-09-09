using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder.UseStartup<NventiveSSDocker.Startup>();
        });

CreateHostBuilder(args).Build().Run();
