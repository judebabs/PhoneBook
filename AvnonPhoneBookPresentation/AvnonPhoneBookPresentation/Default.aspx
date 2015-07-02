<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AvnonPhoneBookPresentation._Default" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent" ng-app="myApp">

    <script src="Scripts/jquery-2.1.4.js"></script>
    <script src="Scripts/jquery-ui-1.11.4.js"></script>
    <script src="Scripts/jquery.dataTables.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet"/>
    <link href="Content/jquery.dataTables.min.css" rel="stylesheet"/>




    <style>
        .img-rounded {
            max-width: 65px;
            max-height: 65px;
        }

        .loadingImageStyle {
            background: url(Images/loadingdata.gif) center no-repeat;
            margin: 0 auto;
        }
    </style>

    <!-- Using Datatables to bind Json data from WebService -->
    <img class="img-responsive loadingImageStyle" id="loadingImage" alt="" src="Images/loadingdata.gif"/>


    <!-- Modal to Add COntact -->
    <!-- Button trigger modal with global contact that can be added to the user phonebook-->
    <button type="button" class="btn btn-info btn-lg pull-right" data-toggle="modal" data-target="#myModal">Add New Contact</button>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog  modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">ADD NEW CONTACT</h4>
                </div>
                <div class="modal-body">
                     
                    <table id="tableContactNew" class="display" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                           <td></td>
                            <td>
                                <div class="row">
                                    <label for="Filter" class="control-label input-group">Filter By :</label>
                                    <div class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-default active ">
                                            <input type="radio" name="filter" Id="filter" value="All" checked="">All Columns
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="filter" Id="filter" value="Department">Department
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="filter" Id="filter" value="Location">Location
                                        </label>
                                    </div>
                                </div>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>Contact</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Location</th>
                            <th>Tag</th>
                          
                        </tr>
                        </thead>

                        <tfoot>
                            <tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </tfoot>
                    </table>
                    <img class="img-responsive loadingImageStyle" id="modalloadingImage" alt="" style="visibility:hidden" src="Images/loading.gif"/>
            
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">CANCEL</button>
                   
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <table id="globalContactTable" class="table table-striped">
        <thead>
        <tr>
            <th></th><!-- Photo -->
            <th>Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Location</th>
            <th>Tag</th>
            
            <th></th><!-- Button Message -->
        </tr>
        </thead>
        <tbody id="tbContactbody">

        </tbody>
    </table>
   
    <script type="text/javascript">

        $(document).ready(CallServiceToGetCurrentUserContacts);
        var dataArray = [];
        var myTable1;
      
        //Hardcoding the default user parameter because authentication/security were not in place 
        //I focus more on the functionalty required , so normaly we will be getting the current logged in use an retrieve contact accordingly
        //Getting Contact Only for the current users so the can populate the default phonebook grid
        function CallServiceToGetCurrentUserContacts() {

            var currentUserName = "Admin"; //Hard Coded , we should request this from Identity
            $('#loadingImage').show();

            $.ajax({
                type: "POST",
                url:'AvnonService.asmx/GetAllContactsForCurrentUser',
                contentType: 'application/json; charset=utf-8',
               
                dataType: 'json',
                success: function(response) {

                    removeLoadingImage();
                    var tr;
                    var jsonDataSet = JSON.parse(response.d);
                    for (var i = 0; i < jsonDataSet.length; i++) {

                        var tagButton = "<button type=\'button\' class=\'btn btn-primary pull-right \'  onclick=\' AddToPhoneBook(" + jsonDataSet[i].ContactName + "); \' >" + "SEND MESSAGE" + "</button>";
                        var contactPhoto = "<img src=\'Images/avatar.gif\' alt=\'contact photo\' class=\'img-rounded \'>";
                        tr = $('<tr/>');
                        tr.append(contactPhoto);
                        tr.append("<td>" + jsonDataSet[i].ContactName + "</td>");
                        tr.append("<td>" + jsonDataSet[i].ContactPhone + "</td>");
                        tr.append("<td>" + jsonDataSet[i].ContactEmail + "</td>");
                        tr.append("<td>" + jsonDataSet[i].ContactLocation + "</td>");
                        tr.append("<td>" + jsonDataSet[i].ContactTag + "</td>");

                        tr.append(tagButton);
                        $('#tbContactbody').append(tr);
                    }
                }
               

            });

            CallServiceForGlobalContacts();
        }

        //Calling global contacts to populate the grid that will be use when we want to ad new contact ( P.S any contact that already exist in the current user phonebook should be removed )
        // and this done in the backEnd so planning to pass the current userId as parameter when doing ajax call and the use the ID to identify which are the contact already associated to him/her
        //(Associated: Belongs to his/her PhoneBook already)
        function CallServiceForGlobalContacts() {

            $('#loadingImage').show();

            var locationparameter = 'd';
            $.ajax({
                type: "POST",
                url: 'AvnonService.asmx/GetAllContacts',
                contentType: 'application/json; charset=utf-8',

                dataType: 'json',
                success: function(response) {
                    dataArray: JSON.parse(response.d);
                 
                    $('#tableContactNew').dataTable({
                        "aaData": JSON.parse(response.d),
                        "dom": '<"toolbar">frtip',
                        "info": false,
                        "aoColumns": [
                            {
                                "mDataProp": "ContactName"
                            },
                            {
                                "mDataProp": "ContactPhone"
                            },
                            {
                                "mDataProp": "ContactEmail"
                            },
                            {
                                "mDataProp": "ContactLocation"
                            },
                            {
                                "mDataProp": "ContactTag"
                            }
                          
                        ]
                    });
                   
                }
            });
           
            
        }

        //Add Contact To the user phone book
        function AddContact() {
           
            RefreshDataInModal();
            $('#myModal').modal(show);
            
        };

        function removeLoadingImage() {

            $('#loadingImage').hide();
            $('#example').fadeIn(2000); 

            return false;
        };

        function removeModalLoadingImage() {

            $('#modalloadingImage').hide();
         
            return false;
        };


        //function to call after the user confirm to tag
        function AddToPhoneBook(ContactName) {

            var strContactName = String(ContactName);
          
            alert(strContactName + " ");
        }

        function RefreshDataInModal() {
            $('#modalloadingImage').css("visibility", "visible");
            return false;
        }

        function AddVisibilityCss() {
            $('#modalloadingImage').removeAttr("visibility");
            return false;
        }



    </script>
</asp:Content>