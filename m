Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 29 May 2007 20:37:44 +0530
Message-ID: <7694D1D9D7B18142A440B52FA1E4AB9702AA5C64@CHN-SNR-MBX01.wipro.com>
From: <rajasekhar.pulluru@wipro.com>
Subject: [uml-devel] modprobe: Can't locate module scsi_debug
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1189900348=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
Cc: rashmi.biswal@wipro.com

This is a multi-part message in MIME format.

--===============1189900348==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A202.81F6A90E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A202.81F6A90E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Am a newbie to linux and UML. I have been trying to modprobe the
scsi_debug,
[root@mandrake82 host]# modprobe scsi_debug
modprobe: Can't locate module scsi_debug

Could someone help me to modprobe successfully?=20
=20
=20
Could these following info be helpful in fixing this problem?
/usr/src dir in uml doesnot have linux kernel source. It just has one
dir for RPM.
=20
And the dir /lib/modules/2.4.20-8um in uml contains only the files
listed below:

[root@mandrake82 2.4.20-8um]# ls
modules.dep             modules.ieee1394map  modules.parportmap
modules.pnpbiosmap
modules.generic_string  modules.isapnpmap    modules.pcimap
modules.usbmap
It doesnot have a dir for drivers/scsi/
=20
=20
Thanks in advance,
Raj
=20
=20
=20
=20

------_=_NextPart_001_01C7A202.81F6A90E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D578355514-29052007>Am a =
newbie to linux=20
and UML. I have been trying to modprobe the =
scsi_debug,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007><STRONG>[root@mandrake82 host]# modprobe=20
scsi_debug<BR>modprobe: Can't locate module=20
scsi_debug</STRONG><BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D578355514-29052007>Could=20
someone&nbsp;help me&nbsp;to modprobe successfully? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D578355514-29052007>Could =
these=20
following&nbsp;info be helpful in fixing this =
problem?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007><STRONG>/usr/src</STRONG> dir in uml doesnot =
have linux=20
kernel source. It just has one dir for RPM.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D578355514-29052007>And =
the dir=20
<STRONG>/lib/modules/2.4.20-8um</STRONG> in uml contains only the files =
listed=20
below:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007><BR><STRONG>[root@mandrake82 2.4.20-8um]#=20
ls<BR>modules.dep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
modules.ieee1394map&nbsp; modules.parportmap&nbsp;=20
modules.pnpbiosmap<BR>modules.generic_string&nbsp;=20
modules.isapnpmap&nbsp;&nbsp;&nbsp; =
modules.pcimap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
modules.usbmap</STRONG><BR></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D578355514-29052007>It doesnot have a dir for=20
<STRONG>drivers/scsi/</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D578355514-29052007>Thanks =
in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007>Raj</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D578355514-29052007>&nbsp;</DIV></SPAN></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7A202.81F6A90E--


--===============1189900348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1189900348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1189900348==--

