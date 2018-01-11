
Imports System.IO
Public Class CheckDuplicate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fileName = Request.Form("fileNameReturn")
        Dim path = "..\FileData\" + fileName
        Dim number As String = Request.Form("number")


        'Try
        '    Using sr As StreamReader = File.OpenText(Server.MapPath(path))
        '        Do While sr.Peek() >= 0

        '        Loop

        '        sr.Close()
        '    End Using
        'Catch ex As Exception

        'End Try

        Try
            Dim lines() As String = IO.File.ReadAllLines(Server.MapPath(path))

            For index As Integer = 0 To lines.Length - 1
                If number = lines(index).Replace(",", "") Then
                    Response.Write(1)
                    Exit Sub
                    'Else
                    '    Response.Write(0)
                    '    Exit Sub
                End If

            Next
            Response.Write(0)
            Exit Sub
        Catch ex As Exception
            Response.Write(ex.ToString)
        End Try

    End Sub

End Class