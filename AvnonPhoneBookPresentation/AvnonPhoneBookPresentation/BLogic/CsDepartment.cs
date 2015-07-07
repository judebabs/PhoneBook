using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using AvnonBackEnd;
using Department = AvnonPhoneBookPresentation.DAL.Department;

namespace AvnonPhoneBookPresentation.BLogic
{
    public class CsDepartment
    {


        private string _resultMessage;

        private List<DAL.Department> _departments;

        //Database settings
        public SqlConnection MyConnection { get; set; }
        public string SqlRelatedErroMessage { get; set; }
        public CsDepartment()
        {
            _resultMessage = "Failed";
            _departments = new List<DAL.Department>();

            //Initialize database setting this will be done in App Setting 
            MyConnection = new SqlConnection("user id=sa;" +
                                      "password=password1234$;server=./;" +
                                      "Trusted_Connection=yes;" +
                                      "database=DB_Avnon_Consulting; " +
                                      "connection timeout=30");
        }

        public List<Department> GetAllDepartments()
        {
            _departments = new List<DAL.Department>();
            //string query = "SELECT * FROM tb_CONTACT";
            //Retrieving data using stored procedure that we created in the DB
            string query = "SP_GET_ALL_DEPARTMENTS";

            try
            {

                SqlCommand readcommand = new SqlCommand();
                readcommand.CommandText = query;
                readcommand.Connection = MyConnection;
                readcommand.CommandType = CommandType.StoredProcedure;
                
                MyConnection.Open();
                SqlDataReader reader = null;

                reader = readcommand.ExecuteReader();
                while (reader.Read())
                {
                    var aDepartment = new DAL.Department();


                    aDepartment.DepartmentName = reader["Dpt_Name"].ToString();
                    string strDepartmentId = reader["Dpt_ID"].ToString().Trim().ToUpper();
                    if (!string.IsNullOrEmpty(strDepartmentId))
                    {
                        aDepartment.DepartmentId = new Guid(strDepartmentId);
                    }

                    _departments.Add(aDepartment);
                }

                _resultMessage = "Success";
            }

            catch (Exception sqlException)
            {
                //for testing purpose
                SqlRelatedErroMessage = sqlException.Message;
            }

            MyConnection.Close();

            return _departments;
        }
        
    }
}
