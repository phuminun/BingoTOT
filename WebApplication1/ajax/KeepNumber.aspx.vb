Imports System.IO

Public Class KeepNumber
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fileName = Request.Form("fileNameReturn")
        Dim path = "..\FileData\" + fileName
        Dim number = Request.Form("number")

        If Not File.Exists(path) Then
            Using sw As StreamWriter = New StreamWriter(Server.MapPath(path))
                sw.WriteLine(number)

                sw.Close()
            End Using
        End If


    End Sub

End Class