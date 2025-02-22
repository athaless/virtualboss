<!--#include file="../virtualboss/_database/athdbConn.asp"--><!-- ATEN��O: language, option explicit, etc... est�o no athDBConn -->
<%
  '---------------------------------------------------------------------------------
  'Escreva aqui nome do BANCO para login a partir desta pasta do cliente
  '---------------------------------------------------------------------------------
  DIM strUser, strPass, strDB, strExtra
  DIM auxStr

  'Estes par�metros acabam vindo de uma "default_LoginViasite.asp". Mais utilizada para 
  'chamadas externas como por exemplo CHAMADOS, login via PORTAL (www.virtualboss.com.br)
  strUser	= GetParam("var_user")
  strPass	= GetParam("var_password")
  strDB		= GetParam("var_db")
  strExtra	= GetParam("var_extra")
  
  
  'SE    recebeu par�metros de login externo, ent�o "vai" por eles
  'SEN�O testa se as vari�veis de sess�o anda tem daos do ultimo login (caso do cara n�o 
  '      ter sa�do e desta forma, entra com este user mesmo
  '---------------------------------------------------------------- by Aless 20/11/12 --
  IF ( (strUser=Empty) AND (strPass=Empty) ) THEN
	  'Request.Cookies("VBOSS")("COD_USUARIO")     
	  'Request.Cookies("VBOSS")("NOME_USUARIO")    
	  'Request.Cookies("VBOSS")("GRUPO_USUARIO")   
	  'Request.Cookies("VBOSS")("DT_LOGIN")        
	  'Request.Cookies("VBOSS")("DEFAULT_EMP")     
	  'Request.Cookies("VBOSS")("CLINAME")         
	  'Request.Cookies("VBOSS")("PATHSTARTED")     
	  'Request.Cookies("VBOSS")("ENTIDADE_CODIGO") 
	  'Request.Cookies("VBOSS")("ENTIDADE_TIPO")   
	  strUser = Request.Cookies("VBOSS")("ID_USUARIO")      
	  strPass = Request.Cookies("VBOSS")("SENHA")           
	  '* Tentativa de ir direto para o m�dulo inicial (modulo_PAINEL)... a reflex�o no 
	  'caso � sobre o fato de n�o ser um "processo chaleira", implicando em poss�veis 
	  'falhas n�o previstas -------------------------------------- by Aless 20/11/12 --
	  'logo capa, mas optei por fazer um novo login pra funcionar como chaleira
	  IF ( (strUser<>Empty) AND (strPass<>Empty) ) THEN
	     response.redirect("../virtualboss/modulo_PAINEL/default.asp")
	     response.end()
	  END IF	 
  END IF
 
    
  'Se n�o mandaram o par�metro do identificador de grupo (sufixo do DB do cliente), ent�o o sistema
  'tenta deduzir atraves do caminho atual 
  auxStr = strDB
  if (auxStr=Empty) then
	auxStr = lcase(Request.ServerVariables("PATH_INFO"))   'retorna: /aspsystems/virtualboss/proevento/login.asp ou /proevento/login.asp
	auxStr = Mid(auxStr,1,inStr(auxStr,"/login.asp")-1)    'retorna: /aspsystems/virtualboss/proevento ou /proevento
	auxStr = replace(auxStr,"/aspsystems/virtualboss/","") 'retorna: proevento ou /proevento
	auxStr = replace(auxStr,"/","")                        'retorna: proevento
  end if
  
  CFG_DB = "vboss_" & auxStr
  'obs: mais adiante a loginverify se encarregar� de colocar num cookie o nome do banco logado
  '---------------------------------------------------------------------------------
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link rel='stylesheet' href='../virtualboss/_css/virtualboss.css'>
</head>
<body onLoad='document.formlogin.var_userid.focus(); if ((document.formlogin.var_userid.value!="") && (document.formlogin.var_senha.value!="")) { document.formlogin.submit(); }'>
<table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr><td height='57' background='../virtualboss/img/BgInterTop.jpg'><img src='../virtualboss/img/LogoVBoss.gif' width='229' height='37' hspace='30'></td></tr>
  <tr><td height='25' valign='top' background='../virtualboss/img/BgTitleLogin.jpg'></td></tr>
  <tr> 
    <td align='center' valign='middle'> 
	 <table width='766' height='337' style="vertical-align:middle" align='center' cellspacing='0' cellpadding='0' border='0'>
        <tr> 
          <td width='540' rowspan='2' valign='top'><img src='../virtualboss/img/BgCapaLoginL.jpg' alt=''></td>
          <td width='226' align="center" valign='top' style=" background-color:#F9F9F9; margin:0px; padding:0px;"> 
            <form name='formlogin' action='../virtualboss/login_verify.asp' method='post'>
			  <input type='hidden' id='var_dbselect' name='var_dbselect' style='width:100px' value='<%=CFG_DB%>'>
			  <input type='hidden' id='var_pstarted' name='var_pstarted' style='width:100px' value='<%=ucase(auxStr)%>'>
			  <input type='hidden' id='var_extra'	 name='var_extra'	 style='width:100px' value='<%=strExtra%>'>
			  <img src='../virtualboss/img/TopLogin.gif' hspace="0" vspace="0">
              <table align='center' width='98' border='0' cellpadding='3' cellspacing='0'>
                <tr> 
                  <td width='66'><img src='../virtualboss/img/IcoDB.gif' width='28' height='18' alt='IDCliente' title='IDCliente'></td>
                  <td width='226' title="<%=CFG_DB%>"><%=ucase(auxStr)%></td>
                </tr>
                <tr> 
                  <td><img src='../virtualboss/img/IcoUser.gif' width='28' height='18' alt='Nome de usu�rio' title='Nome de usu�rio'></td>
                  <td><input type='text' name='var_userid' id='var_userid' value='<%=strUser%>' style='width:160px; border:1px dotted #666666; background-color:#F9F9F9;'></td>
                </tr>
                <tr> 
                  <td><img src='../virtualboss/img/IcoSenha.gif' width='28' height='18' alt='Senha' title='Senha'></td>
                  <td><input type='password' name='var_senha' id='var_senha' value="<%=strPass%>" style='width:100px; border:1px dotted #666666; background-color:#F9F9F9;'></td>
                </tr>
                <tr><td colspan="2" height="5" style="border-bottom:1px solid #CCCCCC"></td></tr>
                <tr> 
                  <td colspan='2' valign='top' >
				    <table width='100%' cellspacing='0' cellpadding='0' border='0'>
					  <tr><td height="5"></td></tr>
                      <tr> 
                        <td style="text-align:right">
						  <img onClick="document.formlogin.submit();" src='../virtualboss/img/butxp_ok.gif' align="right" style="cursor:pointer;">
						  <!-- para gerar o submit do form quando aperta enter -->
						  <input type="image" src="../virtualboss/img/spacer.gif" style="width:1px; height:1px; border:none; background:none;">
						</td>
                      </tr>
					  <tr><td height="5"></td></tr>
                      <tr> 
                        <td class='texto_corpo_peq'>
							<div class="form_line">
							Por favor insira seu nome de usu&aacute;rio e sua senha 
                            para continuar.<br><br>
							<%="<b>"&GetParam("var_erro")&"</b>"%>
                            <!-- <a onClick='Javascript:alert('Fun��o em manuten��o!');' class='texto_corpo_peq' style="cursor:pointer">Esqueceu a senha?</font></a>	-->
							<br><br>ATEN��O: <font color='#999999'>Favor permitir o uso de cookies em seu
						    <a href="#" onClick="document.getElementById('navegadores').style.display = 'block';" title="Navegadores e suas vers�es m�nimas desejadas."> navegador. </a></font><br><br>
							<div id='navegadores' style="display:none;">
								<img src="../virtualboss/img/bullet_iexplorer.jpg"	hspace="1" title="Internet Explorer 8.0">
								<img src="../virtualboss/img/bullet_firefox.jpg" 	hspace="1" title="Fire Fox 3.6">
								<img src="../virtualboss/img/bullet_safari.jpg" 	hspace="1" title="Apple Safari 4.0">
								<img src="../virtualboss/img/bullet_chrome.jpg" 	hspace="1" title="Google Chrome 3.0">
								<img src="../virtualboss/img/bullet_opera.jpg" 		hspace="1" title="Opera 10.1">
							</div>							
							</div>
						</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </form>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>