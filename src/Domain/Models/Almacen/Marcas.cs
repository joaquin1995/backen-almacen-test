using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
    public class Marcas
    {
        public long num_sec { get; set; }
        public string? nombre { get; set; }
        public string? descripcion { get; set; }
        [JsonIgnore]
        public string? estado { get; set; }

    }
}
