using Application.Interfaces.IServices.Administracion;
using Application.Interfaces.IServices.almacen;
using Application.Interfaces.IServices.Sgp;
using Application.Services.Administracion;
using Application.Services.Administracion.Login;
using Application.Services.almacen;
using Application.Services.Sgp;

namespace WebApi.Ioc
{
    public static class IocServices
    {
        public static IServiceCollection AddDependency(this IServiceCollection services)
        {
            //services.AddScoped<LoginFactory>();

            //services.AddScoped<LoginService>()
            //    .AddScoped<ILoginService, LoginService>(s => s.GetService<LoginService>()!);

            //services.AddScoped<LoginActiveDirectoryService>()
            //    .AddScoped<ILoginService, LoginActiveDirectoryService>(s => s.GetService<LoginActiveDirectoryService>()!);


            //services.AddTransient<IMenuService, MenuService>();
            //services.AddTransient<ICantonService, CantonService> ();
            services.AddTransient<ICategoriasService, CategoriasService>();


            return services;
        }
    }
}
