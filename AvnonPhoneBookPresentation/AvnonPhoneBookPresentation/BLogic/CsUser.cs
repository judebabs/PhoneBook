using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AvnonBackEnd;

namespace AvnonBackEndLogic
{
    public class CsUser
    {
        public CsUser()
        {
            
        }

        //Authenticate Current User
        public Boolean AuthenticateUser(string username, string password)
        {
            bool isUserAuthenticated = string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password);

            return isUserAuthenticated;

        }

        public User GetCurrentUserDetails()
        {
            var authenticatedUSer = new User();
            //Some code will go down here
            return authenticatedUSer;
        }
    }
}
