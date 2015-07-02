using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AvnonBackEnd
{
    public class Message
    {
        public Guid MessageId { get; set; }

        public String MessageContent { get; set; }

        public Guid MessageSender { get; set; }

        public Guid MessageReceiver { get; set; }

        public DateTime MessageTimeDateSent { get; set; }

        public Message()
        {
            //Initialize message properties
            
        }
    }
}
