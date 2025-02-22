<!--#include file="../_database/athdbConn.asp"--><%' ATEN��O: language, option explicit, etc... est�o no athDBConn %>
<!--#include file="../_database/athUtils.asp"-->
<%
Dim strSQL, objRS, ObjConn
Dim strDT_AGORA, strMSG
Dim Cont, Desloc, auxStr
Dim strRETORNO, strCODIGO, strTIPO, strCOD_CONTA, strCOD_CENTRO_CUSTO, strCOD_PLANO_CONTA
Dim strVLR_CONTA, strTIPO_DOCUMENTO, strNUM_DOCUMENTO, strDT_EMISSAO, strDT_VCTO_Orig, strDT_VCTO
Dim strHISTORICO, strOBS, strFREQUENCIA, strPARCELAS, strCOD_GRUPO
Dim strSYS_DT_CRIACAO, strTITLE
Dim strCOD_CONTA_PAGAR_RECEBER, strCOD_NF, strNUM_NF, strARQUIVO_ANEXO, strARQUIVO_ANEXO_ORIG
Dim strJSCRIPT_ACTION, strLOCATION

	strCOD_CONTA_PAGAR_RECEBER	= GetParam("var_cod_chavereg")
	strCOD_CONTA				= GetParam("var_cod_conta")
	strCODIGO					= GetParam("var_codigo")
	strTIPO						= GetParam("var_tipo")
	strCOD_CENTRO_CUSTO			= GetParam("var_cod_centro_custo")
	strCOD_PLANO_CONTA			= GetParam("var_cod_plano_conta")
	strOBS						= GetParam("var_obs")
	strHISTORICO				= GetParam("var_historico")
	strVLR_CONTA				= GetParam("var_vlr_conta")
	strTIPO_DOCUMENTO			= GetParam("var_documento")
	strNUM_DOCUMENTO			= GetParam("var_num_documento")
	strDT_VCTO					= GetParam("var_dt_vcto")
	strDT_EMISSAO				= GetParam("var_dt_emissao")
	strARQUIVO_ANEXO			= GetParam("var_arquivo_anexo")
	strARQUIVO_ANEXO_ORIG		= GetParam("var_arquivo_anexo_orig")
	strJSCRIPT_ACTION			= GetParam("JSCRIPT_ACTION")
	strLOCATION					= GetParam("DEFAULT_LOCATION")
	
	If Not IsNumeric(strVLR_CONTA) Then strVLR_CONTA = ""
	If Not IsDate(strDT_EMISSAO) Then strDT_EMISSAO = ""
	If Not IsDate(strDT_VCTO) Then strDT_VCTO = ""
	
	strMSG = ""
	If (strCOD_CONTA = "") Then 					strMSG = strMSG & "Par�metro inv�lido para conta<br>"
	If (strCODIGO = "") Or (strTIPO = "") Then 		strMSG = strMSG & "Informar entidade<br>"
	If (strCOD_CENTRO_CUSTO = "") Then 				strMSG = strMSG & "Informar centro de custo<br>"
	If (strCOD_PLANO_CONTA = "") Then 				strMSG = strMSG & "Informar plano de conta<br>"
	If (strTIPO_DOCUMENTO = "") Then 				strMSG = strMSG & "Informar tipo do documento<br>"
	If (strNUM_DOCUMENTO = "") Then 				strMSG = strMSG & "Informar n�mero do documento<br>"
	If (strVLR_CONTA = "") Or (strVLR_CONTA < 0) Then strMSG = strMSG & "Informar valor do documento<br>"
	If (strDT_EMISSAO = "") Then 					strMSG = strMSG & "Informar data de emiss�o do documento<br>"
	If (strDT_VCTO = "") Then 						strMSG = strMSG & "Informar data de vencimento do documento<br>"
	If (strHISTORICO = "") Then 					strMSG = strMSG & "Informar hist�rico<br>"
	
	If strMSG <> "" Then 
		Mensagem strMSG, "Javascript:history.back();", "Voltar", 1
		Response.End()
	End If
	
	AbreDBConn objConn, CFG_DB 
	
	'-----------------------------
	'Inicializa��es
	'-----------------------------
	strDT_VCTO_Orig = strDT_VCTO
	strDT_VCTO    = "'" & PrepDataBrToUni(strDT_VCTO, False) & "'"
	strDT_EMISSAO = "'" & PrepDataBrToUni(strDT_EMISSAO, False) & "'"
	strDT_AGORA   = "'" & PrepDataBrToUni(Now, True) & "'"
	
	If strVLR_CONTA <> 0 Then
		strVLR_CONTA = FormatNumber(strVLR_CONTA, 2) 
		strVLR_CONTA = Replace(strVLR_CONTA,".","")
		strVLR_CONTA = Replace(strVLR_CONTA,",",".")
	End If
	
	'-------------------------------------------------------------
	'Se for imagem faz a redu��o do arquivo enviado como anexo
	'-------------------------------------------------------------
	If (strARQUIVO_ANEXO <> "") And (strARQUIVO_ANEXO <> strARQUIVO_ANEXO_ORIG) Then
		If UCase(Right(strARQUIVO_ANEXO, 3)) = "JPG" Or UCase(Right(strARQUIVO_ANEXO, 4)) = "JPEG" Then
			ReduzirImagem "../upload/" & Request.Cookies("VBOSS")("CLINAME") & "/FIN_Titulos/", strARQUIVO_ANEXO, 1000
		End If
	End If
	
	'-----------------------------
	'Atualiza dados da conta 
	'-----------------------------
	strSQL =          " UPDATE FIN_CONTA_PAGAR_RECEBER "
	strSQL = strSQL & " SET TIPO = '" & strTIPO & "' "
	strSQL = strSQL & "   , CODIGO = " & strCODIGO
	strSQL = strSQL & "   , COD_CONTA = " & strCOD_CONTA
	strSQL = strSQL & "   , COD_PLANO_CONTA = " & strCOD_PLANO_CONTA
	strSQL = strSQL & "   , COD_CENTRO_CUSTO = " & strCOD_CENTRO_CUSTO
	strSQL = strSQL & "   , HISTORICO = '" & strHISTORICO & "'"
	strSQL = strSQL & "   , OBS = '" & strOBS & "' "
	strSQL = strSQL & "   , TIPO_DOCUMENTO = '" & strTIPO_DOCUMENTO & "' "
	strSQL = strSQL & "   , NUM_DOCUMENTO = '" & strNUM_DOCUMENTO & "' "
	strSQL = strSQL & "   , DT_EMISSAO = " & strDT_EMISSAO
	strSQL = strSQL & "   , DT_VCTO = " & strDT_VCTO
	strSQL = strSQL & "   , VLR_CONTA = " & strVLR_CONTA
	strSQL = strSQL & "   , ARQUIVO_ANEXO = '" & strARQUIVO_ANEXO & "' "
	strSQL = strSQL & "   , SYS_DT_ALTERACAO = " & strDT_AGORA
	strSQL = strSQL & "   , SYS_COD_USER_ALTERACAO = '" & Request.Cookies("VBOSS")("ID_USUARIO") & "' "
	strSQL = strSQL & " WHERE COD_CONTA_PAGAR_RECEBER = " & strCOD_CONTA_PAGAR_RECEBER
	
	objConn.Execute(strSQL)	
	
	FechaDBConn ObjConn
	
	response.write "<script>" & vbCrlf 
	if strJSCRIPT_ACTION <> "" then response.write strJSCRIPT_ACTION & vbCrlf end if
	if strLOCATION <> "" then response.write "location.href='" & strLOCATION & "'" & vbCrlf
	response.write "</script>"
%>