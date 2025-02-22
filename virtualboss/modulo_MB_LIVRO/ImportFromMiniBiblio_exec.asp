<!--#include file="../_database/athdbConn.asp"--><%'-- ATEN��O: language, option explicit, etc... est�o no athDBConn --%>
<% 'VerificaDireito "|IMPORT|", BuscaDireitosFromDB("modulo_MB_LIVRO", Request.Cookies("VBOSS")("ID_USUARIO")), true %>
<!--#include file="../_database/athUtils.asp"-->
<!--#include file="../_scripts/Scripts.js"-->
<%
 Dim objConn, objRS, strSQL
 Dim objFSO, objARQ, strARQ, strPath, strValue
 Dim strAUX, strLINE, arrAUX, arrLINE
 Dim i, intCodCATEG

 'Campos dos arquivo BUFFER_LIVROS.MDB
 const COD		 = 0
 const TITULO	 = 1
 const AUTORES	 = 2 
 const EDITORA	 = 3
 const EDICAO	 = 4 
 const ANO		 = 5
 const CODBAR	 = 6
 const ISBN		 = 7
 const LOCAL	 = 8 
 const PRAZO	 = 9
 const LOCADO	 = 10	 
 const IDIOMA	 = 11
 const AQUISICAO = 12
 const CATEGORIA = 13 
 const ASSUNTO 	 = 14
 const CLASSE	 = 15
 const VOLUME	 = 16
 const EXTRA	 = 17
 const RESENHA	 = 18

 'Par�metro com o nome e path do arquivo para importar	
 strARQ = GetParam("DBVAR_STR_ARQUIVO")

 'Para montagem do PATH+File local pra teste
 set objFSO  = Server.CreateObject("Scripting.FileSystemObject")
 strPath = Server.MapPath("..\upload\" & Request.Cookies("VBOSS")("CLINAME"))
 strARQ  = strPath & "\" & strARQ
 set objARQ  = objFSO.OpenTextFile(strARQ, 1)

 'Verifica se o arquivo � do formato esperado (como n�o temos outra indica��o, testamso o cabe�alho inteiro do mesmo).
 strLine = objARQ.ReadLine 'ignora/pula a primeira linha
 If ucase(strLine)<>"XLW|GRGFOL|ZFGLIVH|VWRGLIZ|VWRXZL|ZML|XLWYZI|RHYM|OLXZO|KIZAL VNKI|OLXZWL|RWRLNZ|ZJFRHRXZL|XZGVTLIRZ|ZHHFMGL|XOZHHV|ELOFNV|VCGIZ|IVHVMSZ" then
   Mensagem "Formato de arquivo n�o reconhecido. Poder�o ser importados somente arquivos de LIVROS do MiniBiblio (buffer_livros.dbb)", "", 1, True
   response.end
 End If  

 'Busca a categoria (por estring mesmo), se n�o existe insere e pega o codigo inserido (melhorar)
 function GetCodCateg(prStrCateg)
	  strSQL = "SELECT COD_CATEGORIA, NOME, DESCRICAO, DT_INATIVO FROM mb_livro_categoria WHERE NOME like '" & prStrCateg & "'"
	  set objRS = objConn.Execute(strSQL)  
	  If Not objRS.EOF Then
		  GetCodCateg = GetValue(objRS,"COD_CATEGORIA")
	  Else  
		  strSQL = "INSERT INTO mb_livro_categoria (NOME) VALUES ('" & prStrCateg & "')"
		  set objRS = objConn.Execute(strSQL)  
	
		  strSQL = "SELECT COD_CATEGORIA, NOME, DESCRICAO, DT_INATIVO FROM mb_livro_categoria WHERE NOME like '" & prStrCateg & "'"
		  set objRS = objConn.Execute(strSQL)  
		  If Not objRS.EOF Then
			GetCodCateg = GetValue(objRS,"COD_CATEGORIA")
		  End If
	  End If
 end function


 ' ------------------------------------------------------------------------------------------------------
 ' INI: Importa��o --------------------------------------------------------------------------------------
 ' ------------------------------------------------------------------------------------------------------
 AbreDBConn objConn, CFG_DB

 set objRS  = objConn.Execute("start transaction")
 set objRS  = objConn.Execute("set autocommit = 0")
 do while objARQ.AtEndOfStream = false
    strLine		= objARQ.ReadLine
	strLine		= ATHMiniBiblioDeCripto(strLine)
	strLine		= replace (strLine,"'","''")
	strLine		= replace (strLine,"""","''")
    arrLine		= split (strLine, "|")
	intCodCATEG = GetCodCateg(arrLine(CATEGORIA))

	'Debug ARRAY...
	'for i=0 to ubound(arrLine)
	' athDebug  "[" & i &  "-" &arrLine(i) & "]", false
	'next
	'athDebug  "<br><br>", false

    strSQL = "INSERT INTO mb_livro "
    strSQL = strSQL & "("
    strSQL = strSQL & "ID,"
    strSQL = strSQL & "TITULO,"
    strSQL = strSQL & "AUTORES,"
    strSQL = strSQL & "EDITORA,"
    strSQL = strSQL & "EDICAO,"
    strSQL = strSQL & "ANO,"
    strSQL = strSQL & "CODBAR,"
    strSQL = strSQL & "ISBN,"
    strSQL = strSQL & "LOCALIZACAO,"
    strSQL = strSQL & "PRAZO_EMPR,"
    strSQL = strSQL & "IDIOMA,"
    strSQL = strSQL & "AQUISICAO," 
    strSQL = strSQL & "COD_CATEGORIA,"
    strSQL = strSQL & "ASSUNTO,"
    strSQL = strSQL & "CLASSE,"
    strSQL = strSQL & "VOLUME,"
    strSQL = strSQL & "EXTRA,"
    'strSQL = strSQL & "IMG_THUMB," 
    'strSQL = strSQL & "IMG," 
    strSQL = strSQL & "RESENHA," 
    strSQL = strSQL & "SYS_ID_USUARIO_INS,"
    strSQL = strSQL & "SYS_DTT_INS" 
	strSQL = strSQL & ") VALUES ("
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(COD)	,1,10) ,"")		& "',"	
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(TITULO),1,250),"")		& "',"
    strSQL = strSQL & "'" & RetValue4SQl(arrLine(AUTORES),"")				& "',"
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(EDITORA),1,250),"")	& "',"
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(EDICAO) ,1,10),"")		& "',"	
    strSQL = strSQL & 		RetValue4SQl(arrLine(ANO),"NULL")				& ","	
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(CODBAR) ,1,25),"")		& "',"	
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(ISBN)	,1,25),"")		& "',"	
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(LOCAL)	,1,20),"")		& "',"
    strSQL = strSQL & 		RetValue4SQl(arrLine(PRAZO),"NULL","")			& ","
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(IDIOMA) ,1,20),"")		& "',"
    strSQL = strSQL & "'" & PrepDataBrToUni(arrLine(AQUISICAO),false) 		& "'," 
    strSQL = strSQL & 		RetValue4SQl(intCodCATEG,"NULL")	    		& ","
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(ASSUNTO),1,250),"")	& "',"
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(CLASSE) ,1,250),"")	& "',"
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(VOLUME) ,1,10),"")		& "',"
    strSQL = strSQL & "'" & RetValue4SQl(mid(arrLine(EXTRA)  ,1,50),"")		& "',"
    strSQL = strSQL & "'" & RetValue4SQl(arrLine(RESENHA),"") 				& "',"
    strSQL = strSQL & "'" & Request.Cookies("VBOSS")("ID_USUARIO") 			& "',"
    strSQL = strSQL & "'" & PrepDataBrToUni(Now(), true) 					& "'"
    strSQL = strSQL	& ")" 

    'Debug SQL
	'athDebug strSQL & "<br><br>" , false

    objConn.Execute(strSQL)  
    If Err.Number <> 0 Then
 	  set objRS = objConn.Execute("rollback")
	  Mensagem "N�o foi poss�vel realizar a importa��o. "  & Err.Number & " - "& Err.Description , "", 1, True
	  Response.End
	else
	  'response.write("[ok]<br>")
	  'for i=0 to ubound(arrLine)
	  '	 response.write("[" & arrLine(i) & "]")
	  'next
	  'response.write("<br><br>")
	  set objRS = objConn.Execute("commit")
	  response.write("<script type='text/javascript' language='javascript'>")
	  response.write("  alert(""Arquivo " & GetParam("DBVAR_STR_ARQUIVO") & " importado com sucesso!"");")
	  response.write("  parent.frames['vbTopFrame'].document.form_principal.submit();")
	  response.write("</script>")
	End If
 loop
 ' ------------------------------------------------------------------------------------------------------
 ' FIM: Importa��o --------------------------------------------------------------------------------------
 ' ------------------------------------------------------------------------------------------------------

 Set objFSO = NOTHING
 FechaDBConn objConn
%>