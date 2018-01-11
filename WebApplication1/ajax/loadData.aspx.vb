Imports Newtonsoft.Json
Imports System.IO
Public Class loadData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fileName = Request.Form("fileNameReturn")
        Dim path = "..\FileData\" + fileName
        Dim number = Request.Form("number")

        'Using sr As StreamReader = File.OpenText(Server.MapPath(path))
        '    Do While sr.Peek() >= 0

        '    Loop
        'End Using

        Try
            Dim lines() As String = IO.File.ReadAllLines(Server.MapPath(path))
            Dim json = JsonConvert.SerializeObject(lines, Formatting.Indented)

            Response.Write(json)
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try



    End Sub

End Class