Imports System.IO
Imports System.Threading

Public Class AppendFile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fileName = Request.Form("fileNameReturn")
        Dim path = "..\FileData\" + fileName
        Dim number = Request.Form("number")

        Try
            Using sw As StreamWriter = File.AppendText(Server.MapPath(path))
                sw.WriteLine("," + number)
                sw.Close()
            End Using


            Thread.Sleep(2000)
            Response.Write("Success")
        Catch ex As Exception

        End Try


    End Sub

End Class