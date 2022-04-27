using Application.DTOs.Administracion;


namespace Application.Interfaces.IServices.Administracion
{
    public interface IMenuService
    {
        public Task<IEnumerable<MenuDto>> TraerMenuPorUsuario(long num_sec, string cuenta, string routerlink);
    }
}
