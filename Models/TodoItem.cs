using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NventiveSSDocker.Models
{
    [Table("todoitems")]
    public class TodoItem
    {
        [Key]
        public string Id { get; set; }
        [Required]
        public string Content { get; set; }
    }
}
