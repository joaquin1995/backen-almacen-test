using System.Text.Json.Serialization;

namespace Application.DTOs.almacen
{
    public class ProductosDto
    {
        public long num_sec { get; set; }
        public long nsec_categoria { get; set; }
        public long nsec_marca { get; set; }
        public string? codigo { get; set; }
        public string? ruta { get; set; }
        public string? nombre { get; set; }
        public decimal precio_venta { get; set; }
        public int stock { get; set; }
        public string? descripcion { get; set; }
        [JsonIgnore]
        public string? estado { get; set; }
        public string? created_at { get; set; }
        public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }

    public class ProductosListadoDto
    {
        public long num_sec { get; set; }
        public long nsec_categoria { get; set; }
        public string? categoria { get; set; }
        public long nsec_marca { get; set; }
        public string? marca { get; set; }
        public string? codigo { get; set; }
        public string? ruta { get; set; }
        public string? nombre { get; set; }
        public decimal precio_venta { get; set; }
        public int stock { get; set; }
        public string? descripcion { get; set; }
        [JsonIgnore]
        public string? estado { get; set; }
        public string? created_at { get; set; }
        public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }
}
