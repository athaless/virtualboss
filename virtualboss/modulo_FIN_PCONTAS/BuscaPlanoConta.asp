<!--#include file="../_database/athdbConn.asp"--><%' ATEN��O: language, option explicit, etc... est�o no athDBConn %>
<!--#include file="../_database/athUtils.asp"-->
<!--#include file="../_scripts/scripts.js"-->
<%
Dim strSQL, objRS, ObjConn
Dim strFORM, strRETORNO1, strRETORNO2
Dim strCOLOR

strFORM		= GetParam("var_form")
strRETORNO1 = GetParam("var_retorno1")
strRETORNO2 = GetParam("var_retorno2")

AbreDBConn objConn, CFG_DB 

%>
<html>
<head>
<title>vboss</title>
<link href="../_css/virtualboss.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript">
<!--
function Retorna(valor1,valor2) { 
	var var_form     = '<%=strFORM%>';
	var var_retorno1 = '<%=strRETORNO1%>';
	var var_retorno2 = '<%=strRETORNO2%>';
	
	if (var_form != '') {		
		if (var_retorno1 != '') eval("self.opener." + var_form + "." + var_retorno1 + ".value = " + valor1 + ";");
		if (var_retorno2 != '') eval("self.opener." + var_form + "." + var_retorno2 + ".value = '../" + valor2 + "';");
	}
	window.close();
}
//-->
</script>
<script type="text/javascript" src="../_scripts/tablesort.js"></script>
<link rel="stylesheet" type="text/css" href="../_css/virtualboss.css">
<link rel="stylesheet" type="text/css" href="../_css/tablesort.css">
</head>
<body onLoad="document.getElementById('form_busca').query.focus();">
<table class="top_table" style="width:100%; height:58px; border:0px; margin:0px; padding:0px; vertical-align:top; border-collapse:collapse; ">
<tr> 
 	<td width="1%" class="top_menu" style="background-image:url(../img/Menu_TopBgLeft.jpg); vertical-align:top; padding:10px 0px 0px 10px; border-collapse:collapse;"></td>
	<td width="1%" class="top_middle" style="background-image:url(../img/Menu_TopImgCenter.jpg); vertical-align:top; padding:0px; margin:0px; border-collapse:collapse;"><img src="../img/Menu_TopImgCenter.jpg"></td>
	<td width="98%" class="top_filtros" style="background-image:url(../img/Menu_TopBgRight.jpg); vertical-align:bottom; padding:0px 5px 5px 0px; margin:0px; text-align:right; border:none; border-collapse:collapse;">
	<div class="form_line">
		<form name="form_busca" id="form_busca" action="?form_busca">
			<!-- phrase --><input type="hidden" class="inputclean" id="phrase" name="phrase" style="width:10px; height:10px;" />
			<!-- cases  --><input type="hidden" class="inputclean" id="cases"  name="cases"  style="width:10px; height:10px;" />
			<!-- regex  --><input type="hidden" class="inputclean" id="regex"  name="regex"  style="width:10px; height:10px;" />&nbsp;&nbsp;&nbsp;

			<input type="text" name="result" id="result" size="10" style="border:0" readonly="readonly" onclick="unhighlight(this.value.substring(this.value.indexOf('x ')+1))"/>
			<label for="query" title=" Alt+Q ">Busca: <input type="text" id="query" name="query" size="15" accesskey="q" class="edtext"  /></label>

			<div onClick="return hi(document.getElementById('form_busca'), 'query', 'result');" class="btsearch"></div>
		</form>
	</div>
	</td>
</tr>
</table>
<%
	strSQL = " SELECT COD_PLANO_CONTA, COD_REDUZIDO, NOME, NIVEL, DT_INATIVO FROM FIN_PLANO_CONTA ORDER BY COD_REDUZIDO, ORDEM, NOME"
	AbreRecordSet objRS, strSQL, objConn, adLockOptimistic, adOpenDynamic, adUseClient, -1
	if not objRS.eof then
%>
<table align="center" cellpadding="0" cellspacing="1" style="width:100%" class="tablesort">
 <thead>
 <tr>
    <th width="01%"></th>
	<th width="09%" class="sortable-numeric">Cod</th>
    <th width="15%" class="sortable" nowrap>Cod Reduzido</th>
	<th width="74%" class="sortable">N�vel/Nome</th>
	<th width="1%"  class="sortable-date-dmy" nowrap="nowrap">Dt Inativo</th>
 </tr>
 </thead>
 <tbody style="text-align:left;">
	<%
	while not objRS.Eof
		strCOLOR = swapString(strCOLOR,"#FFFFFF","#F5FAFA")
	%>
	<tr bgcolor="<%=strCOLOR%>" style="cursor:hand;" onMouseOver="this.style.backgroundColor='#FFCC66';" onMouseOut="this.style.backgroundColor='';" onClick="Retorna('<%=GetValue(objRS,"COD_PLANO_CONTA")%>','<%=GetValue(objRS,"COD_REDUZIDO")%>');">
		<td></td>
		<td style="text-align:right;"><%=GetValue(objRS,"COD_PLANO_CONTA")%></td>
		<td><%=GetValue(objRS,"COD_REDUZIDO")%></td>
		<td><img src="../img/Custos_Nivel<%=GetValue(objRS,"NIVEL")%>.gif" border="0"><%=GetValue(objRS,"NOME")%></td>
		<td style="text-align:right;"><%=PrepData(GetValue(objRS,"DT_INATIVO"), True, False)%></td>
	</tr>
	<%
		objRS.MoveNext
	wend
	%>
 </tbody>
</table>
<%
	else
		Mensagem "N�o h� dados para a consulta solicitada.<br>Verifique os par�metros de filtragem e tente novamente.", "", "", True
	end if
	FechaRecordSet objRS
%>
</body>
</html>
<% FechaDBConn objConn %>