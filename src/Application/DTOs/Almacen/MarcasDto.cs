using System.Text.Json.Serialization;

namespace Application.DTOs.almacen
{
	public class MarcasDto
    {
		public long num_sec { get; set; }
		public string? nombre { get; set; }
		public string? descripcion { get; set; }
        [JsonIgnore]
		public string?  estado { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }
}
