<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
  <title>Inserir carinha</title>
  <style type="text/css">
    <!--
    body { background: ButtonFace; color: ButtonText; font: 11px Tahoma,Verdana,sans-serif;
    margin: 0px; padding: 0px; }
    form p { margin-top: 5px; margin-bottom: 5px; }
    select, input, button { font: 11px Tahoma,Verdana,sans-serif; }
    button { width: 70px; }
    .space { padding: 2px; }
    .title { background: #ddf; color: #000; font-weight: bold; font-size: 14px; padding: 3px 10px; margin-bottom: 10px;
    border-bottom: 1px solid black; letter-spacing: 2px; }
    form { padding: 0px; margin: 0px; }
    .chr { background-color: transparent; border: 1px solid #dcdcdc; font-family: "Times New Roman", times;
    font-size: small; }
    // -->
  </style>
  <script language="javascript" type="text/javascript" src="popup.js"></script>
  <script language="javascript" type="text/javascript">
    window.resizeTo(410, 350);
    function Init() {
      __dlg_init();
    }
    function attr(name, value) {
      if (!value || value == "") return "";
      return ' ' + name + '="' + value + '"';
    }
    function insert(img,text) {
      // pass data back to the calling window
      __dlg_close('<img src="/<%=CFG_DIR_SITE%>/_athcsm/htmlarea/htmlarea/popups/' + img + '" alt="' + text + '" title="' + text + '" border=0>');
      return false;
    };
    function cancel() {
      __dlg_close(null);
      return false;
    };
  </script>
</head>
<body onload="Init()" onUnload="__dlg_close(null);">
<table class="dlg" cellpadding="0" cellspacing="2" width="100%">
  <tr><td><table width="100%"><tr><td class="title" nowrap>Escolher imagem para inserir</td></tr></table></td></tr>
  <tr><td>
    <table border="0" align="center" cellpadding="5">
      <tr valign="top">
        <td>
          <table border="0">
            <tr><td><img alt="sorriso" border="0" hspace="10" src="carinhas/smiley.gif"  onclick="insert('carinhas/smiley.gif','sorriso')" width="15" height="15" /></td><td>sorriso</td><td class="smile">:-)</td></tr>
            <tr><td><img alt="boca aberta" border="0" hspace="10" src="carinhas/biggrin.gif"  onclick="insert('carinhas/biggrin.gif','boca aberta')" width="15" height="15" /></td><td>boca aberta</td><td class="smile">:-D</td></tr>
            <tr><td><img alt="piscando" border="0" hspace="10" src="carinhas/wink.gif"  onclick="insert('carinhas/wink.gif','piscando')" width="15" height="15" /></td><td>piscando</td><td class="smile">;-)</td></tr>
            <tr><td><img alt="perplexo" border="0" hspace="10" src="carinhas/mixed.gif"  onclick="insert('carinhas/mixed.gif','perplexo')" width="15" height="15" /></td><td>perplexo</td><td class="smile">:-/</td></tr>
            <tr><td><img alt="pensativo" border="0" hspace="10" src="carinhas/thoughtful.gif"  onclick="insert('carinhas/thoughtful.gif','pensativo')" width="15" height="15" /></td><td>pensativo</td><td class="smile">V-.</td></tr>
            <tr><td><img alt="mostrando a l�ngua" border="0" hspace="10" src="carinhas/tongueout.gif"  onclick="insert('carinhas/tongueout.gif','mostrando a l�ngua')" width="15" height="15" /></td><td>mostrando a l�ngua</td><td class="smile">:-P</td></tr>
            <tr><td><img alt="maneiro" border="0" hspace="10" src="carinhas/cool.gif"  onclick="insert('carinhas/cool.gif','maneiro')" width="15" height="15" /></td><td>maneiro</td><td class="smile">B-)</td></tr>
            <tr><td><img alt="aprovo" border="0" hspace="10" src="carinhas/approve.gif"  onclick="insert('carinhas/approve.gif','aprovo')" width="15" height="15" /></td><td>aprovo</td><td class="smile">^-)</td></tr>
            <tr><td><img alt="virando os olhos" border="0" hspace="10" src="carinhas/wideeyes.gif"  onclick="insert('carinhas/wideeyes.gif','virando os olhos')" width="15" height="15" /></td><td>virando os olhos</td><td class="smile">8-)</td></tr>
            <tr><td><img alt="surpreso" border="0" hspace="10" src="carinhas/surprise.gif"  onclick="insert('carinhas/surprise.gif','surpreso')" width="15" height="15" /></td><td>surpreso</td><td class="smile">8-o</td></tr>
          </table>
        </td>
        <td>
          <table border="0" align="center">
            <tr><td><img alt="triste" border="0" hspace="10" src="carinhas/sad.gif"  onclick="insert('carinhas/sad.gif','triste')" width="15" height="15" /></td><td>triste</td><td class="smile">:-(</td></tr>
            <tr><td><img alt="t�mido" border="0" hspace="10" src="carinhas/shy.gif"  onclick="insert('carinhas/shy.gif','t�mido')" width="15" height="15" /></td><td>t�mido</td><td class="smile">8-.</td></tr>
            <tr><td><img alt="corado" border="0" hspace="10" src="carinhas/blush.gif"  onclick="insert('carinhas/blush.gif','corado')" width="15" height="15" /></td><td>corado</td><td class="smile">:-I</td></tr>
            <tr><td><img alt="beijos" border="0" hspace="10" src="carinhas/kiss.gif"  onclick="insert('carinhas/kiss.gif','beijos')" width="15" height="15" /></td><td>beijos</td><td class="smile">:-X</td></tr>
            <tr><td><img alt="buf�o" border="0" hspace="10" src="carinhas/clown.gif"  onclick="insert('carinhas/clown.gif','buf�o')" width="15" height="15" /></td><td>buf�o</td><td class="smile">:o)</td></tr>
            <tr><td><img alt="olho roxo" border="0" hspace="10" src="carinhas/blackeye.gif"  onclick="insert('carinhas/blackeye.gif','olho roxo')" width="15" height="15" /></td><td>olho roxo</td><td class="smile">P-|</td></tr>
            <tr><td><img alt="zangado" border="0" hspace="10" src="carinhas/angry.gif"  onclick="insert('carinhas/angry.gif','zangado')" width="15" height="15" /></td><td>zangado</td><td class="smile">8-[</td></tr>
            <tr><td><img alt="morto" border="0" hspace="10" src="carinhas/dead.gif"  onclick="insert('carinhas/dead.gif','morto')" width="15" height="15" /></td><td>morto</td><td class="smile">xx-P</td></tr>
            <tr><td><img alt="sonolento" border="0" hspace="10" src="carinhas/sleepy.gif"  onclick="insert('carinhas/sleepy.gif','sonolento')" width="15" height="15" /></td><td>sonolento</td><td class="smile">|-.</td></tr>
            <tr><td><img alt="diab�lico" border="0" hspace="10" src="carinhas/evil.gif"  onclick="insert('carinhas/evil.gif','diab�lico')" width="15" height="15" /></td><td>diab�lico</td><td class="smile">}-]</td></tr>
          </table>
        </td>
      </tr>
    </table>
  </td></tr>
  <tr><td><table width="100%"><tr><td valign="middle" width="90%"><hr width="100%"></td></tr></table></td></tr>
  <tr><td align="right"><button type="button" onclick="return cancel();">Fechar</button></td></tr>
</table>
</body>
</html>
