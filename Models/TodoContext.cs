using System;
using Microsoft.EntityFrameworkCore;

namespace NventiveSSDocker.Models
{
    public class TodoContext : DbContext
    {
        public DbSet<TodoItem> TodoItems { get; set; }

        public TodoContext(DbContextOptions<TodoContext> options)
            : base(options) {}
    }
}
