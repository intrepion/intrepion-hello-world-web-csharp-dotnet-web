var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/HealthCheck", () => "");
app.MapGet("/", () => "Hello, world!");

app.Run();

public partial class Program {}
