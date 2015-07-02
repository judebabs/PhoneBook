using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AvnonBackEnd
{
    public class User
    {
        public Guid UserUniqueId { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public User()
        {
            //Initialize a user
        }
    }
}
