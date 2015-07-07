using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using CsContact = AvnonPhoneBookPresentation.BLogic;

namespace AvnonPhoneBookPresentation
{
    /// <summary>
    /// Summary description for AvnonService
    /// </summary>
    //[WebService(Namespace = "http://tempuri.org/")]
    [WebService(Namespace = "AvnonPhoneBookPresentation")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [ScriptService]
    public class AvnonService : System.Web.Services.WebService
    {

        private List<DAL.Contact> _contacts = null; 

        public string HelloWorld()
        {
            return "Hello World";
        }

        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetAllContactsForCurrentUser()
        {
            var context = new CsContact.CsContact();
            _contacts = context.GetPhonebookContacts("Admin");
            return new JavaScriptSerializer().Serialize(_contacts);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetAllContacts()
        {
           var context = new CsContact.CsContact();
            _contacts = context.GetAllContacts();
           return new JavaScriptSerializer().Serialize(_contacts);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetAllContactsByLocation(string searchquery)
        {

            var context = new CsContact.CsContact();
            _contacts = context.GetAllContactByLocation(searchquery);

            return new JavaScriptSerializer().Serialize(_contacts);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetAllContactsByDepartment(string searchquery)
        {
            var context = new CsContact.CsContact();
            _contacts = context.GetAllContactByDepartmentName(searchquery);

            return new JavaScriptSerializer().Serialize(_contacts);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetContactByTag(string tag)
        {
            return new JavaScriptSerializer().Serialize(_contacts);
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string AddContactToPhoneBook(string currentuserid, string taggeduserid)
        {
            //Use the current user Id to find the appropriate phonebook that belong to him/her and then attach taggedUserId  to that phonebook
            string _message = "Failed";

            return _message;
        }

        //Overloaded method of get all contacts but accept a parameter
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetAllContactsGlobal(string searchquery)
        {
            var context = new CsContact.CsContact();
            _contacts = context.GetAllContacts();
            return new JavaScriptSerializer().Serialize(_contacts);
        }
    }
}
