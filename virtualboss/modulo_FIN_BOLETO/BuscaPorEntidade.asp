<!--#include file="../_database/athdbConn.asp"--> <%' ATEN��O: language, option explicit, etc... est�o no athDBConn %>
<!--#include file="../_database/athUtils.asp"--> 
<!--#include file="../_scripts/Scripts.js"--> 
<%
Dim objConn, objRS, strSQL  
Dim strNOME, strTABLE, strTYPE
Dim strPALAVRA_CHAVE, strFORM, strTIPO, strINPUT1, strINPUT2
Dim strFormName

AbreDBConn objConn, CFG_DB 
strINPUT1	= GetParam("var_input1")
strINPUT2	= GetParam("var_input2")
strTIPO		= GetParam("var_tipo")
strFormName = GetParam("var_form")
if IsEmpty(strFormName) then strFormName= "form_insert"
%>
<html>
<head>
<title>vboss</title>
<link rel="stylesheet" href="../_css/virtualboss.css" type="text/css">
<script>
function Retorna(valor1,valor2) { 
var objOption;
	window.opener.document.<%=strFormName%>.<%=strINPUT1%>.value = valor1;
	window.opener.document.<%=strFormName%>.<%=strINPUT2%>.value = valor2;
	window.close();
}
</script>
</head>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<table align="center" cellpadding="0" cellspacing="0" width="100%" height="58">
	<tr>
		<td width="4%" background="../img/Menu_TopBGLeft.jpg"></td>
		<td width="1%" ><img src="../img/Menu_TopImgCenter.jpg"></td>
		<td width="95%" background="../img/Menu_TopBgRight.jpg">
			<div style="padding-top:20px;padding-right:3px;"> 
				<table align="right" height="30" cellpadding="0" cellspacing="0" border="0">
					<form name="FormBusca" method="post" action="BuscaPorEntidade.asp">
					<input name="var_form" type="hidden" value="<%=strFormName%>"><%'Form que deve ser enviado o valor%>
					<input name="var_input1" type="hidden" value="<%=strINPUT1%>"><%'Nome do input que recebe o valor%>
					<input name="var_input2" type="hidden" value="<%=strINPUT2%>"><%'Nome do input que recebe o valor%>					
					<tr>
						<td width="100" align="right" nowrap>Nome</td>
						<td width="5"></td>
						<td width="100"><input name="var_palavra_chave" type="text" size="20" class="edtext" value="<%=strPALAVRA_CHAVE%>"></td>
						<td width="5"></td>
						<td width="50">
							<select name="var_tipo" class="edtext" size="1">
								<% MontaCombo "STR", "SELECT TIPO, DESCRICAO FROM SYS_ENTIDADE WHERE TIPO='" & strTIPO & "' ORDER BY ORDEM, DESCRICAO ", "TIPO", "DESCRICAO", strTIPO %>
							</select>
						</td>
						<td width="5"></td>
						<td width="27"><a href="javascript:document.FormBusca.submit();"><img src="../img/bt_search_mini.gif" alt="Atualizar consulta..."  border="0"></a></td>
					</tr>
					</form>
				</table>
			</div>
		</td>
	</tr>
</table>
<%
	strSQL = ""
	'If strTIPO = "ENT_FORNECEDOR" Then	
	'	strSQL = " SELECT COD_FORNECEDOR AS CODIGO, NOME_FANTASIA AS NOME, EMAIL, DT_INATIVO FROM ENT_FORNECEDOR " 
	'	If strPALAVRA_CHAVE <> "" Then
	'		strSQL = strSQL & " WHERE (NOME_FANTASIA LIKE '%" & strPALAVRA_CHAVE & "%' OR RAZAO_SOCIAL LIKE '%" & strPALAVRA_CHAVE & "%' OR NOME_COMERCIAL LIKE '%" & strPALAVRA_CHAVE & "%') " 
	'	End If 
	'	strSQL = strSQL & " ORDER BY 2 " 
	'End If 
	If strTIPO = "ENT_CLIENTE" Then 
		strSQL = " SELECT COD_CLIENTE AS CODIGO, NOME_FANTASIA AS NOME, EMAIL, NUM_DOC, DT_INATIVO FROM ENT_CLIENTE " 
		If strPALAVRA_CHAVE <> "" Then
			strSQL = strSQL & " WHERE (NOME_FANTASIA LIKE '%" & strPALAVRA_CHAVE & "%' OR RAZAO_SOCIAL LIKE '%" & strPALAVRA_CHAVE & "%' OR NOME_COMERCIAL LIKE '%" & strPALAVRA_CHAVE & "%') " 
		End If 
		strSQL = strSQL & " ORDER BY 2 " 
	End If 
	'If strTIPO = "ENT_COLABORADOR" Then 
	'	strSQL = " SELECT COD_COLABORADOR AS CODIGO, NOME, EMAIL, DT_INATIVO FROM ENT_COLABORADOR " 
	'	If strPALAVRA_CHAVE <> "" Then
	'		strSQL = strSQL & " WHERE (NOME LIKE '%" & strPALAVRA_CHAVE & "%') " 
	'	End If 
	'	strSQL = strSQL & " ORDER BY 2 " 
	'End If
   Set objRS = objConn.Execute(strSQL) 
   if not objRS.Eof then
%>
<table cellpadding="0" cellspacing="1" width="99%" align="center">
	<tr><td height="2" colspan="3"></td></tr>
	<tr bordercolordark="#CCCCCC" bordercolorlight="#CCCCCC"> 
		<td width="1%"  bgcolor="#CCCCCC" align="left" class="arial11Bold"><div style="padding-left:3px; padding-right:3px;">Cod </div></td>
		<td width="91%" bgcolor="#CCCCCC" align="left" class="arial11Bold"><div style="padding-left:3px; padding-right:3px;">Nome/N.Fantasia</div></td>
	</tr>
<%
      Dim Ct, strCOLOR 
      Ct = 1  
      while not objRS.Eof
  	     strCOLOR   = "#DAEEFA"
%>
	<tr bgcolor=<%=strCOLOR%> style="cursor:hand;" onMouseOver="this.style.backgroundColor='#FFCC66';" onMouseOut="this.style.backgroundColor='';" onClick="Retorna('<%=GetValue(objRS,"NOME")%>','<%=GetValue(objRS,"NUM_DOC")%>');"> 
		<td align="left" valign="middle" nowrap><div style="padding-left:3px; padding-right:3px;"><%=GetValue(objRS,"CODIGO")%>&nbsp;</div></td>
		<td align="left" valign="middle"><div style="padding-left:3px; padding-right:3px;"><%=GetValue(objRS,"NOME")%>&nbsp;</div></td>
	</tr>
<%
        Ct = Ct + 1
        objRS.MoveNext
      wend
%>
	<tr><td bgcolor="#CCCCCC" colspan="11" align="center" height="1"></td></tr>
</table>
<%
		FechaRecordSet objRS
	else
		Mensagem "N�o h� dados para a consulta solicitada.<br>Verifique os par�metros de filtragem e tente novamente.", "", "", True
	end if
%>
</body>
</html>
<% FechaDBConn objConn %>