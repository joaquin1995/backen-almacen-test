using Application.Interfaces.IData;
using Application.Interfaces.IRepositories.Administracion;
using Application.Interfaces.ISecurity;
using Application.Interfaces.IServices.Administracion;
using Application.Security;
using Application.Services.Administracion.Login;
using Infrastructure.Persistence;
using Infrastructure.Repositories.Administracion;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using WebApi.Ioc;
using WebApi.Middlewares;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

builder.Services.AddApiVersioning(config =>
{
    config.AssumeDefaultVersionWhenUnspecified = true;
    config.DefaultApiVersion = new ApiVersion(1, 0);
    config.ReportApiVersions = true;
    config.ApiVersionReader = ApiVersionReader.Combine(
        new QueryStringApiVersionReader("api-version"),
        new HeaderApiVersionReader("X-Version"),
        new MediaTypeApiVersionReader("ver"));
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Injection DBs
builder.Services.AddSingleton<AdministracionContext>();
builder.Services.AddScoped<IApplicationDbContext, ApplicationDbContext>();

// Injection Security
builder.Services.AddScoped<IJwtTokenGenerator, JwtTokenGenerator>();
builder.Services.AddScoped<IPasswordHasher, PasswordHasher>();

// =============================   Injectio Repository - Services ===================================

IocRepository.AddDependency(builder.Services);
IocServices.AddDependency(builder.Services);

// ============================= Fin Injectio Repository - Services =================================

// ============================= Token ====================================

builder.Services.Configure<JwtIssuerOptions>(
    builder.Configuration.GetSection(JwtIssuerOptions.Schemes));

builder.Services.Configure<LoginOption>(
    builder.Configuration.GetSection(LoginOption.Schemes));



builder.Services.AddCors(options => options.AddPolicy("CorsPolicy", builder =>
        builder
        .WithOrigins("http://localhost:4200", "http://10.10.54.189:4200", "*")
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials()));


ConfigurationManager configuration = builder.Configuration;
IWebHostEnvironment environment = builder.Environment;
builder.Services.AddAuthentication()
                .AddJwtBearer(options =>
                    options.TokenValidationParameters = new TokenValidationParameters
                    {

                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = configuration["Bearer:Issuer"],
                        ValidAudience = configuration["Bearer:Audience"],
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Bearer:SecretKey"])),
                        ClockSkew = TimeSpan.Zero
                    });

// builder.WebHost.UseUrls("http://0.0.0.0:5030");

var app = builder.Build();

app.UseCors("CorsPolicy");

// Middleware
app.UseMiddleware<ErrorHandlingMiddleware>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
