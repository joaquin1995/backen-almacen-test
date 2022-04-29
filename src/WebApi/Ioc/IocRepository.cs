using Application.Interfaces.Common;
using Application.Interfaces.IRepositories.Administracion;
using Application.Interfaces.IRepositories.almacen;
using Infrastructure.Repositories.Administracion;
using Infrastructure.Repositories.almacen;
using Infrastructure.Repositories.Common;

namespace WebApi.Ioc
{
    public static class IocRepository
    {
        public static IServiceCollection AddDependency(this IServiceCollection services)
        {
            services.AddTransient(typeof(IGenericRepository<>), typeof(GenericRepository<>));
            services.AddTransient<ICategoriasRepository, CategoriasRepository>();
            services.AddTransient<IMarcasRepository, MarcasRepository>();
            services.AddTransient<IClientesRepository, ClientesRepository>();
            services.AddTransient<IDetalleIngresosRepository, DetalleIngresosRepository>();
            services.AddTransient<IProductosRepository, ProductosRepository>();
            //services.AddTransient<ILoginRepository, LoginRepository>();
            //services.AddTransient<ICantonRepository,CantonRepository>();
            //services.AddTransient<IMenuRepository, MenuRepository>();


            return services;
        }
    }
}
