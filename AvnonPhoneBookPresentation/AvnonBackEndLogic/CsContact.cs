using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using AvnonBackEnd;

namespace AvnonBackEndLogic
{
    public class CsContact
    {
        private string _resultMessage;

        private List<Contact> _contacts;

        //Database settings
        public SqlConnection MyConnection { get; set; }
        public string SqlRelatedErroMessage { get; set; }

        public CsContact()
        {
            _resultMessage = "Failed";
            _contacts = null;

            //Initialize database setting this will be done in App Setting 
            MyConnection = new SqlConnection("user id=sa;" +
                                      "password=password1234$;server=FPJUDBABA1;" +
                                      "Trusted_Connection=yes;" +
                                      "database=DB_Avnon_Consulting; " +
                                      "connection timeout=30");
        }
        
       

        //All the contacts
        public List<Contact> GetAllContacts()
        {
            string query = "SELECT * FROM tb_CONTACT";
            try
            {
                MyConnection.Open();
                SqlDataReader reader = null;
                var dataSetRetrievedCommand = new SqlCommand(query,MyConnection);
                reader = dataSetRetrievedCommand.ExecuteReader();

                while (reader.Read())
                {
                    var aContact = new Contact
                    {
                        ContactId = new Guid(reader["ContactID"].ToString()),
                        ContactName = reader["FirstName"].ToString(),
                        ContactPhone = reader["Telephone"].ToString(),
                        ContactEmail = reader["Email_Address"].ToString(),
                        ContactTag = reader["ContactTag"].ToString(),
                        ContactUserId = new Guid(reader["ContactUserId"].ToString()),
                        ContactDeptId = new Guid(reader["Dpt_ID"].ToString()),
                        ContactLocation = reader["ContactLocation"].ToString(),
                        ContactPhotoId = new Guid(reader["ContactPhotoId"].ToString())
                    };
                }

                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }
            return _contacts;
        }

        //by Department
        public List<Contact> GetAllContactsByDepartements(Guid departementid)
        {
            return _contacts;
        }

        // by Tag
        public Contact GetContact(Guid tag)
        {
            var contact = new Contact();

            return contact;
        }

        //by Location
        public List<Contact> GetAllContactByLocation(string location)
        {

            return _contacts;
        }

        //Add a contact to user phone Book
        public string AddContactToUserPhoneBook(Guid contactid)
        {
            if (true) 
            {
                _resultMessage = "Success";
            }

            return _resultMessage;
        }
        
    }
}
