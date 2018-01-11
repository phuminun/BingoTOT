<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="WebApplication1._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <link href="SweetAlert/sweetalert.css" rel="stylesheet" />
    <script src="SweetAlert/sweetalert.min.js"></script>
    <link href="css/BingoCss.css" rel="stylesheet" />
    <title>::Bingo::</title>

    <script type="text/javascript">

        var cnt = 1;
        //var flagCheck = false;
        $(document).ready(function () {
            $('#displayNumber').text(0).css({
                'font-size': '220pt',
                'font-family': 'Arial Bold',
                'color': '#f8e101',
                'padding-top': '100px'
            });
            clearTable();
        });

        function RandomBingo() {
            //alert(cnt);
            $('#displayNumber').html("");
            $('#displayNumber').html("<img src='img/Replace-2R-256px.gif'/>");
            //$('#loadingmessage').show();
            var number = Math.floor((Math.random() * 24) + 1);
            $('#displaycnt').text(cnt);
            //$('#displayNumber').text(number).css('font-size', 130);

            //alert(fileNameReturn);

            if (fileNameReturn == "") {
                $('#displayNumber').text(0).css({
                    'font-size': '220pt',
                    'font-family': 'Arial Bold',
                    'color': '#f8e101'
                });
                swal("กรุณากดปุ่มเริ่มใหม่");
                $('#loadingmessage').hide();
                return false; 
            }


            data = "fileNameReturn=" + fileNameReturn + "&number=" + number; 
            if (cnt == 1) {
                
                $.ajax({
                    url: "ajax/KeepNumber.aspx",
                    method: "POST",
                    data: data,
                    success: function (data) {
                       
                        $('#displayNumber').text(number).css({
                            'font-size': '220pt',
                            'font-family': 'Arial Bold',
                            'color': '#f8e101'
                        });
                        loadData(fileNameReturn);
                        cnt++;
                        $('#loadingmessage').hide();
                    }
                });

            } else {

                $.ajax({
                    url: "ajax/CheckDuplicate.aspx",
                    method: "POST",
                    data: data,
                    success: function (data) {

                        //alert(data);

                        if (data == "1") {
                            RandomBingo();

                        }
                        
                        else {
                            //$('#loadingmessage').show();
                            $('#displayNumber').html("<img src='img/Replace-2R-256px.gif'/>");
                                $.ajax({
                                    url: "ajax/AppendFile.aspx",
                                    method: "POST",
                                    data: "fileNameReturn=" + fileNameReturn + "&number=" + number,
                                    success: function (data) {
                                        if (data == 'Success') {
                                            
                                            $('#displayNumber').text(number).css({
                                                'font-size': '220pt',
                                                'font-family': 'Arial Bold',
                                                'color': '#f8e101'
                                            });
                                            loadData(fileNameReturn);
                                            $('#loadingmessage').hide();
                                        }                                       
                                    }
                                });
                                cnt++;
                               
                        }
                    }
                });
               $('#loadingmessage').hide();
            }

            if (cnt > 24) {
                //cnt = 0;

                //$('#tableDisplay').empty();
                //clearTable();
                swal("จบเกมส์");
                fileNameReturn = "";
                flagCheck = false;
                $('#loadingmessage').hide();
                return false; 
            }
        }

       
        var fileNameReturn = "";

        function NewGame() {
            clearTable();
            cnt = 1;


            $('#displayNumber').text(0).css({
                'font-size': '220pt',
                'font-family': 'Arial Bold',
                'color': '#f8e101'
            });
            $('#displaycnt').text(cnt);

            $.ajax({
                url: "ajax/CreateTextFileaspx.aspx",
                method: "POST",
                data: {},
                success: function (data) {
                    fileNameReturn = data;
                    swal("กดปุ่มสุ่มตัวเลข");
                    $('#loadingmessage').hide();
                }
            });
        }
        

        function loadData(fileNameReturn) {
            data = "fileNameReturn=" + fileNameReturn;
            $.ajax({
                url: "ajax/loadData.aspx",
                method: "POST",
                dataType: "json",
                data: data,
                success: function(data) {
                    for (i = 0; i <= 23 ; i++) {
                        $('#row' + (i + 1)).html(data[i].toString().replace(",", "")).css({
                            'font-size': '150pt',
                            'font-family': 'Arial Bold',
                            'color': '000000'
                        });
                    }
                }
            });
        }

        function clearTable() {
            for (i = 1 ; i <= 24; i++) {
                $('#row' + i).html("<img src='TOTMan/" + i + ".jpg'/>");
            }
        }
    </script>
</head>
<body style="background-image:url('resoucre/bg.png'); background-repeat :repeat-x ">
    <div style="width:100%;margin:auto ;">

    
    <form id="form1" runat="server">
    <br /><br /><br /><br />
    
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <h1>Bingo</h1>
        </div>
        <div class="col-md-4">
            ครั้งที่ 
            <div id="displaycnt">

            </div>
        </div>
    </div>
        <div class="container-fluid ">
            <div class="row">
                <div class="col-md-3 text-center">
                    <a href="#" onclick="RandomBingo()">
                        <img src="resoucre/Random.png" />
                    </a>
                </div>
                <div class="col-md-6 text-center">

                    <div id="displayNumber" style="background-image: url('resoucre/totman_number.png'); background-repeat: no-repeat; min-height: 610px; margin-left: 300px">
                    </div>

       <%--             <div id='loadingmessage' style="display: none">
                        <img src="img/Replace-2R-256px.gif" />
                    </div>--%>

                </div>
                <div class="col-md-3 text-center">
                    <a href="#" onclick="NewGame()">
                        <img src="resoucre/newGame.png" />
                    </a>
                </div>
            </div>
        </div>

    
    <div class="row">
        <div class="col-md-12">

            <table class="table table-bordered" id="tableDisplay">
                <tr>
                    <th colspan="12" style="text-align:center ">
                        <img src="resoucre/before.png" />
                    </th>
                </tr>
                <tr>
                    <td id="row1" style="text-align: center"></td>
                    <td id="row2" style="text-align: center"></td>
                    <td id="row3" style="text-align: center"></td>
                    <td id="row4" style="text-align: center"></td>
                    <td id="row5" style="text-align: center"></td>
                    <td id="row6" style="text-align: center"></td>
                    <td id="row7" style="text-align: center"></td>
                    <td id="row8" style="text-align: center"></td>
                    <td id="row9" style="text-align: center"></td>
                    <td id="row10" style="text-align: center"></td>
                    <td id="row11" style="text-align: center"></td>
                    <td id="row12" style="text-align: center"></td>
                </tr>
                <tr>
                    <td id="row13" style="text-align: center"></td>
                    <td id="row14" style="text-align: center"></td>
                    <td id="row15" style="text-align: center"></td>
                    <td id="row16" style="text-align: center"></td>
                    <td id="row17" style="text-align: center"></td>
                    <td id="row18" style="text-align: center"></td>
                    <td id="row19" style="text-align: center"></td>
                    <td id="row20" style="text-align: center"></td>
                    <td id="row21" style="text-align: center"></td>
                    <td id="row22" style="text-align: center"></td>
                    <td id="row23" style="text-align: center"></td>
                    <td id="row24" style="text-align: center"></td>
                </tr>
            </table>
        </div>
    </div>
    </form>
    </div>
</body>
</html>
