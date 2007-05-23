Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 23 May 2007 15:37:50 +0530
Message-ID: <7694D1D9D7B18142A440B52FA1E4AB9702A207C3@CHN-SNR-MBX01.wipro.com>
From: <rajasekhar.pulluru@wipro.com>
Subject: [uml-devel] doubt in debugging.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1856501001=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: jdike@karaya.com

This is a multi-part message in MIME format.

--===============1856501001==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C79D21.A4044F12"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79D21.A4044F12
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guys,
   =20
Am a newbie to linux and UML.I have installed UML(mandrake) in my linux
system. And I started UML from my host linux system using the command:
=20
    ./linux ubd0=3Droot_fs eth0=3Dtuntap,,,10.145.93.183 debug
=20
I get the gdb xterm and another one for uml.
=20
I have written a basic character ram disk driver( which writes n read
one byte of ram).This .c is in  /root/raj/chardev/ directory in uml and
I stored it as chardriver.c and compiled it with proper kernel flags to
get chardriver.o
=20
This chardriver.o is in uml now.
Then I insmoded it and it got loaded.
=20
When I typed print *module_list in gdb, it said chardriver is loaded.
then i typed:
printf "0x%08x", (int)module_list + module_list->size_of_struct
it gave me 0xa307b060
but when i asked gdb to add the symbols by:
add-symbol-file /root/raj/chardev/chardriver.o 0xa307b060
=20
adding symbol tabel from file "chardriver.o" at .text_addr =3D =
0xa307b060
(y or n)  yes
to which it replied =20
chardriver.o: No such file or directory
=20
=20
how to proceed ? kindly help me out.
=20
Regards,
Raj
=20
=20

------_=_NextPart_001_01C79D21.A4044F12
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>Hi=20
Guys,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007>&nbsp;&nbsp;&nbsp;=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D546373609-23052007>Am a newbie to =
linux and UML.I=20
have installed UML(mandrake) in my linux system. And&nbsp;I started UML =
from my=20
host linux system using the command:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D546373609-23052007><STRONG></STRONG></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D546373609-23052007><STRONG>&nbsp;&nbsp;&nbsp; ./linux =
ubd0=3Droot_fs=20
eth0=3Dtuntap,,,10.145.93.183 debug</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007>I&nbsp;get the gdb=20
xterm and another one for uml.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007>I&nbsp;have written=20
a basic character ram disk driver( which writes n read one byte of=20
ram).This&nbsp;.c is&nbsp;in&nbsp;<STRONG> /root/raj/chardev/ =
</STRONG>directory=20
in uml and I&nbsp;stored it as chardriver.c and compiled it with proper =
kernel=20
flags to get </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007>chardriver.o</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>This =
chardriver.o is=20
in uml now.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007>Then&nbsp;I insmoded=20
it and it got loaded.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007>When&nbsp;I&nbsp;typed <STRONG>print=20
*module_list</STRONG> in gdb, it said chardriver is =
loaded.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>then i =

typed:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007><STRONG>printf=20
"0x%08x", (int)module_list +=20
module_list-&gt;size_of_struct</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>it =
gave me=20
0xa307b060</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>but =
when i asked gdb=20
to add the symbols by:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007><STRONG>add-symbol-file =
/root/raj/chardev/chardriver.o=20
0xa307b060</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D546373609-23052007><STRONG>adding=20
symbol tabel from file "chardriver.o" at .text_addr =3D 0xa307b060 (y or =
n)=20
</STRONG>&nbsp;<FONT color=3D#0000ff>yes</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>to =
which it=20
replied&nbsp; </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007><STRONG>chardriver.o: No such file or=20
directory</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D546373609-23052007>how to =
proceed ?=20
kindly help me out.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007>Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D546373609-23052007>Raj</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C79D21.A4044F12--


--===============1856501001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1856501001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1856501001==--

