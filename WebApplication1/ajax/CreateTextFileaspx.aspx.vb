
Imports System.IO
Public Class CreateTextFileaspx
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim r As New Random
        Dim randomStr As String = "bingo" + r.Next.ToString + ".txt"
        Dim path As String = "..\FileData\" + randomStr

        If Not File.Exists(Path) Then
            Using sw As StreamWriter = File.CreateText(Server.MapPath(path))

                sw.Close()

            End Using


        End If


        Response.Write(randomStr)

    End Sub

End Class