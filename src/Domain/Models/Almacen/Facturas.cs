using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
    public class Facturas
    {
        public long num_sec { get; set; }
        public int nsec_cliente { get; set; }
        public int nsec_usuario { get; set; }
        public string? nro_factura { get; set; }

    }
}
