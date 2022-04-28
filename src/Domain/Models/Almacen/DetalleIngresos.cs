using System.Text.Json.Serialization;

namespace Domain.Models.almacen
{
    public class DetalleIngresos
    {
        public long num_sec { get; set; }
        public long nsec_ingreso { get; set; }
        public long nsec_producto { get; set; }
        public int cantidad { get; set; }
        public decimal precio { get; set; }

    }
}
