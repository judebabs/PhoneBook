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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">ADD NEW CONTACT</h4>
            </div>
            <div class="modal-body">


                <table>
                    <tr class="row">
                        <td>
                            <label for="filterLabel" class="control-label input-group" id="filterLabel">Filter By :</label>
                        </td>
                        <td style="padding-right: 20px;"> </td>
                        <td>
                            <div>

                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-default active ">
                                        <input type="radio" name="filter" Id="filterId1" value="default" checked="checked">All Columns
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio" name="filter" Id="filterId2" value="department">Department
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio" name="filter" Id="filterId3" value="location">Location
                                    </label>
                                </div>
                            </div>
                        </td>

                        <td style="padding-right: 95px;"></td>

                        <td>
                            <input type="text" id="searchTextBox" name="searchTextBox" placeholder="Search for a contact..." class="form-control input pull-right"/>
                        </td>
                    </tr>
                </table>

                <!-- Table That will be dynamically get update on each ajax call -->
                <table id="tableglobalcontacts" class="table table-hover">
                    
                    <thead>
                    <tr>
                        <td> CONTACT NAME</td>
                        <td> TELEPHONE</td>
                        <td> EMAIL</td>
                        <td> LOCATION</td>
                        <td> </td>
                    </tr>
                    </thead>

                    <tbody id="tableglobalcontactsbody">
                    
                    </tbody>
                </table>

             <%--   <table id="tableContactNew" class="table table-hover">
                    <thead>
                    <tr>
                        <th>Contact</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th id="col_location">Location</th>
                        <th>Tag</th>
                    </tr>
                    </thead>
                    <tbody id="tableContactNewBody">

                    </tbody>
                </table>--%>
                <img class="img-responsive loadingImageStyle" id="modalloadingImage" alt="" style="visibility: hidden" src="Images/loading.gif"/>

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


    var dataArray = [];
    var myTable1;
    var dataQuery = '';
    var filterId = 'default';
    var strfilter = 'Default';
    var filteredSearchUrl = '';
    var newContactsCounter = 5;
    var staticTableRowsCounter = 0; //Static variable to hold number of rows for every table creation



    $(document).ready(function() {

        CallServiceToGetCurrentUserContacts();

        $("input[name=filter]:radio").change(function(e) {
            e.preventDefault();
            strfilter = $("input:checked").val();
            $("label[for='filterLabel']").text(" Filter by " + strfilter);
            searchCriteriasHasChanged();

        });

    });

    //deetect any seach criterias changes
    function searchCriteriasHasChanged() {

        dataQuery = $("#searchTextBox").val();


        if (strfilter == 'department' && dataQuery.length > 1) {
            filteredSearchUrl = 'AvnonService.asmx/GetAllContactsByDepartment';
            createNewRowsIntoTable();
        }
        else if (strfilter == 'location' && dataQuery.length > 1) {
            filteredSearchUrl = 'AvnonService.asmx/GetAllContactsByLocation';
            createNewRowsIntoTable();
        }
        else {
            filteredSearchUrl = 'AvnonService.asmx/GetAllContactsGlobal';
            createNewRowsIntoTable();
        }
    }

    //Hardcoding the default user parameter because authentication/security were not in place 
    //I focus more on the functionalty required , so normaly we will be getting the current logged in use an retrieve contact accordingly
    //Getting Contact Only for the current users so the can populate the default phonebook grid
    function CallServiceToGetCurrentUserContacts() {

        var currentUserName = "Admin"; //Hard Coded , we should request this from Identity
        $('#loadingImage').show();

        $.ajax({
            type: "POST",
            url: 'AvnonService.asmx/GetAllContactsForCurrentUser',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(response) {


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
            },
            error: function(e) {

                var str = e.message;
                //called when there is an error
                //console.log(e.message);
            }


        });
        CallServiceForGlobalContacts();

    }

    //Calling global contacts to populate the grid that will be use when we want to ad new contact ( P.S any contact that already exist in the current user phonebook should be removed )
    // and this done in the backEnd so planning to pass the current userId as parameter when doing ajax call and the use the ID to identify which are the contact already associated to him/her
    //(Associated: Belongs to his/her PhoneBook already)
    function CallServiceForGlobalContacts() {

        $('#loadingImage').show();

        $.ajax({
            type: "POST",
            url: 'AvnonService.asmx/GetAllContacts',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(response) {

              
                var jsonDataSet = JSON.parse(response.d);
                for (var counter = 0; counter < jsonDataSet.length; counter++) {

                        var tagButton = "<button type=\'button\' class=\'btn btn-primary pull-right \'  onclick=\' AddToPhoneBook(" + jsonDataSet[counter].ContactName + "); \' >" + "TAG" + "</button>";
                        var html = "<tr id='" + "row_" + counter + "'><td>" + jsonDataSet[counter].ContactName + "</td>" + "<td>" + jsonDataSet[counter].ContactPhone + "</td> <td>" + jsonDataSet[counter].ContactEmail + " </td> <td>" + jsonDataSet[counter].ContactLocation + " </td><td>" + tagButton + "</td> </tr>";
                        $("#tableglobalcontactsbody").append(html);
                    
                }
                staticTableRowsCounter = jsonDataSet.length;
                removeLoadingImage();
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

       //Function that will handle text querry changed
    $("#searchTextBox").keyup(function() {

        searchCriteriasHasChanged();

    });

    function createNewRowsIntoTable() {

        try
        {
            for (var addcounter = 0; addcounter < staticTableRowsCounter; addcounter++)
            {
                $("#row_" + addcounter).remove();
              
            }
            callServiceForFilteredResult();
        }
        catch (e)
        {

        }
       
    }

    function callServiceForFilteredResult() {

        var dataObject = { 'searchquery': dataQuery };
        $.ajax({
            type: "POST",
            url: filteredSearchUrl,
            data: JSON.stringify(dataObject),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(response) {

                var jsonDataSet = JSON.parse(response.d);
                for (var counter = 0; counter < jsonDataSet.length; counter++) {

                    var tagButton = "<button type=\'button\' class=\'btn btn-primary pull-right \'  onclick=\' AddToPhoneBook(" + jsonDataSet[counter].ContactName + "); \' >" + "TAG" + "</button>";
                    var html = "<tr id='" + "row_" + counter + "'><td>" + jsonDataSet[counter].ContactName+"</td>" +"<td>"+ jsonDataSet[counter].ContactPhone + "</td> <td>" + jsonDataSet[counter].ContactEmail + " </td> <td>" + jsonDataSet[counter].ContactLocation + " </td><td>" + tagButton + "</td> </tr>";
                    $("#tableglobalcontactsbody").append(html);

                }
                staticTableRowsCounter = jsonDataSet.length;
                removeLoadingImage();
            }


        });
    }


</script>
</asp:Content>