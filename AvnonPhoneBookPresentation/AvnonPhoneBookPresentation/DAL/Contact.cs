using System;

namespace AvnonPhoneBookPresentation.DAL
{
    public class Contact
    {

        public Contact()
        {
            
        }

        public Guid ContactId { get; set; }

        public string ContactName { get; set; }

        public string ContactPhone { get; set; }

        public string ContactEmail { get; set; }

        public string ContactTag { get; set; }

        public Guid ContactUserId { get; set; }

        public Guid ContactDeptId { get; set; }

        public string ContactLocation { get; set; }

        public Guid ContactPhotoId { get; set; }


    }
}
