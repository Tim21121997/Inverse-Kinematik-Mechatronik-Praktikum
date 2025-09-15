%/*
%*
%*		Author:			Dr. Maik Lorch
%*      Adapted by:     Marcel Hallgarten, Philipp Hallgarten        
%*		Email:			maik.lorch@kit.edu;
%*		Version:		MTP2020
%*
%*		Keine Verwendung / Änderung ohne Rücksprache
%*		No usage / edit without permission
%*/
%/* =====================================================================
%*     Achtung:   Zum benutzen dieser Funktionen ist die Matlab Toolbox JSONLab nötig!
%*     Attention: You will need Matlab Toolbox "JSONLab" to use these
%                 functions!
%*/



user=['G13'];
pwd=['13'];
setname=['Testset_G13'];


saveValItem(user, pwd, setname, 'n', '2', 'INT32', 0, 0);
saveValItem(user, pwd, setname, 'x', '2.2', 'DOUBLE', 0, 0);


getVal(user, pwd, setname, 'n', 'INT32')
  
%saveVals(user,pwd,setname,{'x', 'n'},{'DOUBLE','INT32'}, [1.23, 333])
%getVals(user,pwd,setname,{'x', 'n'})
