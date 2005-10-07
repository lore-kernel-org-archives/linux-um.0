Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENqEn-0001cg-Aj	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 04:18:05 -0700
Received: from 209.67.210.11.i-datacenter.com ([209.67.210.11]
	helo=ispbrasil.com.br)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1ENqEl-0003Fr-KY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 04:18:05 -0700
Message-ID: <004f01c5cb31$43a68630$01fea8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
References: <229e70f20510070245t6abdfe69s88a323bec24ba8be@mail.gmail.com>
Subject: Re: [uml-devel] RPM problem in UML rootfs of FC4
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0046_01C5CB18.1A6D6E00"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 7 Oct 2005 08:21:23 -0300
To: Etay Meiri <etay.meiri@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0046_01C5CB18.1A6D6E00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

first try this

rm -rf /var/lib/rpm/__*
rpm --rebuilddb

if don=B4t fix the problem try this




echo "%__dbi_cdb  create cdb private mpool mp_mmapsize=3D16Mb" > =
/etc/rpm/macros

rpm -qa

upgrade your FC4 using yum and remove the line "%__dbi_cdb  create cdb =
private mpool mp_mmapsize=3D16Mb" from /etc/rpm/macros

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br

  ----- Original Message -----=20
  From: Etay Meiri=20
  To: user-mode-linux-devel@lists.sourceforge.net=20
  Sent: Friday, October 07, 2005 6:45 AM
  Subject: [uml-devel] RPM problem in UML rootfs of FC4


  Hi,

  Was anyone successful in getting rpm running in the FC4 root fs from:
  http://uml.harlowhill.com/index.php/UML_Fedora_Core_4    ?

  I followed all the instructions, UML is working fine but all rpm =
invocations
  cause the following error:

  [root@uml-test ~]# rpm -qa
  rpmdb: unable to initialize mutex: Function not implemented
  rpmdb: /var/lib/rpm/__db.001: unable to initialize environment lock: =
Function not implemented
  error: db4 error(38) from dbenv->open: Function not implemented
  error: cannot open Packages index using db3 - Function not implemented =
(38)
  error: cannot open Packages database in /var/lib/rpm

  Thanks,

  --=20
  ------------------------------------------------------
  Etay Meiri
  etay.meiri@gmail.com 
------=_NextPart_000_0046_01C5CB18.1A6D6E00
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2722" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>first try this</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>rm -rf /var/lib/rpm/__*</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rpm --rebuilddb</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>if don=B4t fix the problem try =
this</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><EM>echo "%__dbi_cdb&nbsp; create cdb private mpool =
mp_mmapsize=3D16Mb" &gt;=20
/etc/rpm/macros</EM></DIV>
<DIV><EM></EM>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>rpm -qa</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>upgrade your FC4 using yum and remove =
the line=20
<EM><FONT face=3D"Times New Roman" size=3D3>"%__dbi_cdb&nbsp; create cdb =
private=20
mpool mp_mmapsize=3D16Mb" from /etc/rpm/macros</FONT></EM></FONT></DIV>
<DIV><BR>Itamar Reis Peixoto<BR>+55 (34) 3238 3845<BR>e-mail : <A=20
href=3D"mailto:itamar@ispbrasil.com.br">itamar@ispbrasil.com.br</A><BR></=
DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Detay.meiri@gmail.com =
href=3D"mailto:etay.meiri@gmail.com">Etay=20
  Meiri</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Duser-mode-linux-devel@lists.sourceforge.net=20
  =
href=3D"mailto:user-mode-linux-devel@lists.sourceforge.net">user-mode-lin=
ux-devel@lists.sourceforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Friday, October 07, 2005 =
6:45=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [uml-devel] RPM =
problem in UML=20
  rootfs of FC4</DIV>
  <DIV><BR></DIV>Hi,<BR><BR>Was anyone successful in getting rpm running =
in the=20
  FC4 root fs from:<BR><A=20
  =
href=3D"http://uml.harlowhill.com/index.php/UML_Fedora_Core_4">http://uml=
.harlowhill.com/index.php/UML_Fedora_Core_4</A>&nbsp;&nbsp;&nbsp;=20
  ?<BR clear=3Dall><BR>I followed all the instructions, UML is working =
fine but=20
  all rpm invocations<BR>cause the following =
error:<BR><BR>[root@uml-test ~]#=20
  rpm -qa<BR>rpmdb: unable to initialize mutex: Function not=20
  implemented<BR>rpmdb: /var/lib/rpm/__db.001: unable to initialize =
environment=20
  lock: Function not implemented<BR>error: db4 error(38) from =
dbenv-&gt;open:=20
  Function not implemented<BR>error: cannot open Packages index using =
db3 -=20
  Function not implemented (38)<BR>error: cannot open Packages database =
in=20
  /var/lib/rpm<BR><BR>Thanks,<BR><BR>--=20
  <BR>------------------------------------------------------<BR>Etay =
Meiri<BR><A=20
  href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.com</A>=20
</BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0046_01C5CB18.1A6D6E00--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
