using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
    public class DetalleVentas
    {
        public long num_sec { get; set; }
        public long nsec_venta { get; set; }
        public long nsec_prodcuto { get; set; }
        public int cantidad { get; set; }
        public decimal precio { get; set; }
        public decimal descuento { get; set; }
    }
}
