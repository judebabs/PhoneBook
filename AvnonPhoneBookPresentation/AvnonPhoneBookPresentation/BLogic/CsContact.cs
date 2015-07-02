using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using AvnonPhoneBookPresentation.DAL;

namespace AvnonPhoneBookPresentation.BLogic
{
    public class CsContact
    {
        private string _resultMessage;

        private List<DAL.Contact> _contacts;

        //Database settings
        public SqlConnection MyConnection { get; set; }
        public string SqlRelatedErroMessage { get; set; }

        public CsContact()
        {
            _resultMessage = "Failed";
            _contacts = new List<DAL.Contact>();

            //Initialize database setting this will be done in App Setting 
            MyConnection = new SqlConnection("user id=sa;" +
                                      "password=password1234$;server=./;" +
                                      "Trusted_Connection=yes;" +
                                      "database=DB_Avnon_Consulting; " +
                                      "connection timeout=30");
        }
        
       

        //All the contacts as List<Contact>
#region GET ALL CONTACT FROM DB
        public List<DAL.Contact> GetAllContacts()
        {
            _contacts = new List<DAL.Contact>();
            //string query = "SELECT * FROM tb_CONTACT";
            //Retrieving data using stored procedure that we created in the DB
            string query = "SP_GET_ALL_CONTACTS";
          
            try
            {

                SqlCommand readcommand = new SqlCommand();
                readcommand.CommandText = query;
                readcommand.Connection = MyConnection;
                readcommand.CommandType = CommandType.StoredProcedure;
                readcommand.Parameters.AddWithValue("@userId","5F45B55F-4851-4BC9-AF27-76757F5B1C09"); //Hardcoded the Id of the current user because there is no authentication in place
                MyConnection.Open();
                SqlDataReader reader = null;

                reader = readcommand.ExecuteReader();
                while (reader.Read())
                {
                    var aContact = new DAL.Contact
                    {
                        ContactName = reader["ContactName"].ToString(),
                        ContactPhone = reader["Telephone"].ToString(),
                        ContactEmail = reader["Email_Address"].ToString(),
                        ContactTag = reader["ContactTag"].ToString(),
                        ContactLocation = reader["ContactLocation"].ToString(),
                    };


                    string strContactId = reader["ContactId"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strContactId))
                    {
                        aContact.ContactId = new Guid(strContactId);
                    }

                    string strDeptId = reader["Dpt_ID"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strDeptId))
                    {
                        aContact.ContactDeptId = new Guid(strDeptId);
                    }

                    string strUserId = reader["UserID"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strUserId))
                    {
                        aContact.ContactUserId = new Guid(strUserId);
                    }

                    string strContactPhototId =
                           reader["ContactPhotoId"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strContactPhototId))
                    {
                        aContact.ContactPhotoId = new Guid(strContactPhototId);
                    }
                    _contacts.Add(aContact);
                }

                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }

            MyConnection.Close();
          
            return _contacts;
        }
#endregion


        //by Department
        public List<DAL.Contact> GetPhonebookContacts(string usernamequery) //We will expect username of the current user or the GUID of the phonebook that belong to the user
        {
            

            _contacts = new List<DAL.Contact>();
             var phonebookcontacts = new List<Contact>();
            _contacts = GetAllContacts();
            //string query = "SELECT * FROM tb_CONTACT";
            //Retrieving data using stored procedure that we created in the DB
            string query = "SP_GET_PHONEBOOK_CONTACTS";

            try
            {

                SqlCommand readcommand = new SqlCommand();
                readcommand.CommandText = query;
                readcommand.Connection = MyConnection;
                readcommand.CommandType = CommandType.StoredProcedure;
                readcommand.Parameters.AddWithValue("@userId", "5F45B55F-4851-4BC9-AF27-76757F5B1C09"); //Hardcoded the Id of the current user because there is no authentication in place
                MyConnection.Open();
                SqlDataReader reader = null;

                reader = readcommand.ExecuteReader();
                while (reader.Read())
                {
                    
                    var strContactId = reader["ContactId"].ToString().Trim().ToUpper();

                    if (!string.IsNullOrEmpty(strContactId))
                    {
                        var contactId = new Guid(strContactId);
                        var contact = _contacts.Where(x => x.ContactId.Equals(contactId)).SingleOrDefault();
                        phonebookcontacts.Add(contact);
                    }

                }

                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }

            MyConnection.Close();
            Thread.Sleep(2000); //Just to check if the loading gif works
            return phonebookcontacts;
        }

        //by Department
        public List<DAL.Contact> GetAllContactsByDepartements(string departementhquery)
        {

            _contacts = new List<DAL.Contact>();
            //string query = "SELECT * FROM tb_CONTACT";
            //Retrieving data using stored procedure that we created in the DB
            string query = "SP_GET_CONTACTS_BY_DEPT ";

            try
            {
               
                SqlCommand readcommand = new SqlCommand();
                readcommand.CommandText = query;
                readcommand.Connection = MyConnection;
                readcommand.CommandType = CommandType.StoredProcedure;
                readcommand.Parameters.AddWithValue("@department", departementhquery);
                MyConnection.Open();
                SqlDataReader reader = null;

                reader = readcommand.ExecuteReader();
                while (reader.Read())
                {
                    var aContact = new DAL.Contact
                    {
                        ContactName = reader["ContactName"].ToString(),
                        ContactPhone = reader["Telephone"].ToString(),
                        ContactEmail = reader["Email_Address"].ToString(),
                        ContactTag = reader["ContactTag"].ToString(),
                        ContactLocation = reader["ContactLocation"].ToString(),
                    };


                    string strContactId = reader["ContactId"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strContactId))
                    {
                        aContact.ContactId = new Guid(strContactId);
                    }

                    string strDeptId = reader["Dpt_ID"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strDeptId))
                    {
                        aContact.ContactDeptId = new Guid(strDeptId);
                    }

                    string strUserId = reader["UserID"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strUserId))
                    {
                        aContact.ContactUserId = new Guid(strUserId);
                    }

                    string strContactPhototId =
                           reader["ContactPhotoId"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strContactPhototId))
                    {
                        aContact.ContactPhotoId = new Guid(strContactPhototId);
                    }
                    _contacts.Add(aContact);
                }

                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }

            MyConnection.Close();

            return _contacts;

            /* THIS CODE SEGMENT HAS BEEN DEPRECIATED NOW WE ARE USING STORED PROCEDURES WHICH RESIDES INSIDE THE DATABASE TO PERFORM CRUD OPERATIONS */
            //_contacts = GetAllContacts();
            //departementhquery = departementhquery.ToLower();

            //var contactByDept = new List<DAL.Contact>();

            //if (_contacts.Count > 0)
            //{
            //    _contacts = _contacts.Where(x => x.ContactName.ToLower().Contains(departementhquery)).Take(10).ToList();
            //}

            //return _contacts;
        }

        //by Location
        public List<DAL.Contact> GetAllContactByLocation(string locationquery)
        {
            locationquery = locationquery.ToLower();
            _contacts = GetAllContacts();

            var contactByDept = new List<DAL.Contact>();

            if (_contacts.Count > 0)
            {
                _contacts = _contacts.Where(x => x.ContactLocation.ToLower().Contains(locationquery)).Take(10).ToList();
            }

            return _contacts;
        }

        //by Location
        public List<DAL.Contact> GetAllContactByTag(string tagquery)
        {
            tagquery = tagquery.ToLower();
            _contacts = GetAllContacts();

            var contactByDept = new List<DAL.Contact>();

            if (_contacts.Count > 0)
            {
                _contacts = _contacts.Where(x => x.ContactTag.ToLower().Contains(tagquery)).Take(10).ToList();
            }

            return _contacts;
        }



        //Exact Name of the Contact
        public DAL.Contact GetContact(string namequery)
        {
            _contacts = GetAllContacts();
            DAL.Contact contact = new DAL.Contact();

            return _contacts.Count > 0 ? _contacts.SingleOrDefault(x => x.ContactName.ToLower().Equals(namequery)) : null;
        }

        //Get By exact Tag
        public DAL.Contact GetContactByTag(string tagquery)
        {
            _contacts = GetAllContacts();
            return _contacts.Count > 0 ? _contacts.SingleOrDefault(x => x.ContactName.ToLower().Equals(tagquery)) : null;
        }


        //Add a contact to user phone Book
        public string AddContactToUserPhoneBook(Guid contactid)
        {
           
            //HARDCODED CURRENT USER SINCE WE HAVE NO AUTHENTICATION IN PLACE
            string currentUser = "5F45B55F-4851-4BC9-AF27-76757F5B1C09";

            //EXECUTE THE STORED PROCEDURE THAT WILL ADD A CONTACT TO THE USER PHONEBOOK
            SqlCommand addcommand = MyConnection.CreateCommand();
            addcommand.CommandText = "EXECUTE SP_ADD_NEW_CONTACT_TO_PHONEBOOK @UserId,@ContactId";
            addcommand.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = currentUser;
            addcommand.Parameters.Add("@ContactId", SqlDbType.UniqueIdentifier).Value = contactid;
            try
            {
                MyConnection.Open();
                addcommand.ExecuteNonQuery();
                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }

            MyConnection.Close();

            return _resultMessage;

        }

      
    }
}

