using System.Text.Json.Serialization;

namespace Application.DTOs.almacen
{
	public class PersonasDto
    {
		public long num_sec { get; set; }
		public long nsec_rol { get; set; }
		public string? nombre { get; set; }
		public string? tipo_documento { get; set; }
		public string? num_documento { get; set; }
		public string? direccion { get; set; }
		public string? telefono { get; set; }
		public string? email { get; set; }
		public string? password { get; set; }
        [JsonIgnore]
		public string?  estado { get; set; }
		public string? created_at { get; set; }
		public string? updated_at { get; set; }

        [JsonIgnore]
        public int total { get; set; }
    }
}
