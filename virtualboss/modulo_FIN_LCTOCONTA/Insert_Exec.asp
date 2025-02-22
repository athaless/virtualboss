<!--#include file="../_database/athdbConn.asp"--><%' ATEN��O: language, option explicit, etc... est�o no athDBConn %>
<!--#include file="../_database/athUtils.asp"-->
<%
Dim strSQL, objRS, ObjConn, objRSCT
Dim strSYS_DT_CRIACAO, strSYS_COD_USER_CRIACAO
Dim strCOD_CONTA, strOPERACAO, strCODIGO_ENT
Dim strTIPO_ENT, strCOD_CENTRO_CUSTO, strCOD_PLANO_CONTA
Dim strNUM_LCTO, strVLR_LCTO, strDT_LCTO
Dim strHISTORICO, strOBS, strMSG
Dim strNOVO_SALDO, strVLR_SALDO
Dim strJSCRIPT_ACTION, strLOCATION

	strCOD_CONTA 			= GetParam("var_cod_conta")
	strOPERACAO 			= GetParam("var_operacao")
	strCODIGO_ENT			= GetParam("var_codigo")
	strTIPO_ENT 		 	= GetParam("var_tipo")
	strCOD_CENTRO_CUSTO		= GetParam("var_cod_centro_custo")
	strCOD_PLANO_CONTA		= GetParam("var_cod_plano_conta")
	strNUM_LCTO				= GetParam("var_num_lcto")
	strVLR_LCTO				= Replace(GetParam("var_vlr_lcto"),".","")
	strDT_LCTO				= GetParam("var_dt_lcto")
	strHISTORICO			= GetParam("var_historico")
	strOBS					= GetParam("var_obs")
	strJSCRIPT_ACTION 		= GetParam("JSCRIPT_ACTION")
	strLOCATION 			= GetParam("DEFAULT_LOCATION")
	
	strSYS_DT_CRIACAO		= Now()
	strSYS_COD_USER_CRIACAO = Request.Cookies("VBOSS")("ID_USUARIO")
	
	AbreDBConn objConn, CFG_DB 
	
	strMSG = ""
	if strCOD_CONTA=""			then strMSG = strMSG & "Par�metro inv�lido para conta<br>"
	if strOPERACAO=""			then strMSG = strMSG & "Par�metro inv�lido para opera��o<br>"
	if (strCODIGO_ENT = "") or (strTIPO_ENT = "") then strMSG = strMSG & "Informar entidade<br>"
	if strCOD_CENTRO_CUSTO=""	then strMSG = strMSG & "Informar centro de custo<br>"
	if strCOD_PLANO_CONTA=""	then strMSG = strMSG & "Informar plano de conta<br>"
	if strNUM_LCTO=""	 		then strMSG = strMSG & "Informar n�mero do lan�amento<br>"
	if strVLR_LCTO=""  			then strMSG = strMSG & "Informar valor do lan�amento<br>"	
	if strDT_LCTO=""			then strMSG = strMSG & "Informar data do lan�amento<br>"
	'if strHISTORICO=""			then strMSG = strMSG & "Informar hist�rico<br>"
	if not IsDate(strDT_LCTO) then 
		strDT_LCTO = Date
	else
		if CDate(strDT_LCTO) > Date then strMSG = strMSG & "N�o � permitido lan�amento com data futura (" & strDT_LCTO & ")<br>"
	end if
	
	if strCOD_CONTA<>"" then			
		strSQL = "SELECT NOME, DT_CADASTRO FROM FIN_CONTA WHERE COD_CONTA=" & strCOD_CONTA
		AbreRecordSet objRS, strSQL, objConn, adLockOptimistic, adOpenDynamic, adUseClient, -1
		if not objRS.eof then	
			while not objRS.eof
				if CDate(strDT_LCTO) < CDate(GetValue(objRS,"DT_CADASTRO")) then
					strMSG = strMSG & "A data do lan�amento (" & strDT_LCTO & ") n�o corresponde com a data de cria��o da conta "
					strMSG = strMSG & GetValue(objRS,"NOME") & " (" & GetValue(objRS,"DT_CADASTRO") & ").<br>"	
				end if
				objRS.MoveNext		
			wend
		end if
	end if	
	if strMSG <> "" then 
		Mensagem strMSG, "Javascript:history.go(-1);", "Voltar", 1
		Response.End()
	end if
	
	'Insere os dados e valores do novo lan�mento
	strSQL = "INSERT INTO FIN_LCTO_EM_CONTA"	&_
				"	(	COD_CONTA,"	&_
				"		OPERACAO,"	&_
				"		TIPO,"		&_
				"		CODIGO,"		&_
				"		HISTORICO,"	&_
				"		COD_PLANO_CONTA,"	 &_												
				"		COD_CENTRO_CUSTO," &_												
				"		NUM_LCTO,"	&_
				"		DT_LCTO,"	&_
				"		VLR_LCTO,"	&_
				"		OBS,"			&_
				"		SYS_DT_CRIACAO,"	&_
				"		SYS_COD_USER_CRIACAO"	&_
				"	) "	&_
				"VALUES" &_
				"	("& 	strCOD_CONTA	& "," &_
				"	'" &	strOPERACAO		& "'," &_
				"	'" &	strTIPO_ENT 	& "'," &_
				"	" &	strCODIGO_ENT	& "," &_
				"	'"	& 	strHISTORICO	& "'," &_ 
				"	"	& 	strCOD_PLANO_CONTA	& "," &_ 
				"	"	& 	strCOD_CENTRO_CUSTO	& "," &_ 								
				"	'" &	strNUM_LCTO	& "'," &_ 
				"	'" &	PrepDataBrToUni(strDT_LCTO,false) & "'," &_ 
				"	"  &	Replace(strVLR_LCTO,",",".") & "," &_ 
				"	'"	&	strOBS & "'," &_ 
				"	'"	&	PrepDataBrToUni(strSYS_DT_CRIACAO,true) & "'," &_ 
				"	'"	&	strSYS_COD_USER_CRIACAO & "'" &_ 
				"	)"
	
	'AQUI: NEW TRANSACTION
	set objRSCT  = objConn.Execute("start transaction")
	set objRSCT  = objConn.Execute("set autocommit = 0")
	objConn.Execute(strSQL)  
	If Err.Number <> 0 Then
	  set objRSCT = objConn.Execute("rollback")
	  Mensagem "modulo_FIN_LCTOCONTA.Insert_Exec A: " & Err.Number & " - "& Err.Description , DEFAULT_LOCATION, 1, True
 	  Response.End()
	else
	  set objRSCT = objConn.Execute("commit")
	End If
	
	'Insere novo saldo na conta de ORIGEM
	strSQL = "SELECT VLR_SALDO FROM FIN_CONTA WHERE COD_CONTA=" & strCOD_CONTA
	AbreRecordSet objRS, strSQL, objConn, adLockOptimistic, adOpenDynamic, adUseClient, -1
	if GetValue(objRS,"VLR_SALDO")<>"" then
		strVLR_SALDO = GetValue(objRS,"VLR_SALDO")
	else
		strVLR_SALDO = 0
	end if
	
	if strOPERACAO="DESPESA" then	
		strNOVO_SALDO = CDbl(strVLR_SALDO) - CDbl(strVLR_LCTO)
	else
		strNOVO_SALDO = CDbl(strVLR_SALDO) + CDbl(strVLR_LCTO)
	end if
	strNOVO_SALDO = FormataDecimal(strNOVO_SALDO, 2)
	strNOVO_SALDO = FormataDouble(strNOVO_SALDO)

	
	strSQL = "UPDATE FIN_CONTA SET VLR_SALDO=" & strNOVO_SALDO & " WHERE COD_CONTA=" & strCOD_CONTA
	'AQUI: NEW TRANSACTION
	set objRSCT = objConn.Execute("start transaction")
	set objRSCT = objConn.Execute("set autocommit = 0")
	objConn.Execute(strSQL)
	If Err.Number <> 0 Then
	  set objRSCT = objConn.Execute("rollback")
	  Mensagem "modulo_FIN_LCTOCONTA.Insert_Exexc B: " & Err.Number & " - "& Err.Description , DEFAULT_LOCATION, 1, True
 	  Response.End()
	else
	  set objRSCT = objConn.Execute("commit")
	End If
	
	if strOPERACAO="DESPESA" then	 
		AcumulaSaldoNovo objConn, strCOD_CONTA, strDT_LCTO, -strVLR_LCTO
	else
		AcumulaSaldoNovo objConn, strCOD_CONTA, strDT_LCTO, strVLR_LCTO
	end if
	
	FechaDBConn objConn
	
response.write "<script>"
If strJSCRIPT_ACTION <> "" Then response.write replace(strJSCRIPT_ACTION,"''","'")
If strLOCATION <> "" Then response.write " location.href='" & strLOCATION & "'"
response.write "</script>"
%>