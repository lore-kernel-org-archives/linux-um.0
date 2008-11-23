Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <foolishzhu@yahoo.cn>) id 1L47Hr-0003tb-Mn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Nov 2008 05:13:35 +0000
Received: from web92202.mail.cnh.yahoo.com ([203.209.250.115])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1L47Hk-0001Bh-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Nov 2008 05:13:35 +0000
Date: Sun, 23 Nov 2008 13:13:19 +0800 (CST)
From: Xm Zhu <foolishzhu@yahoo.cn>
MIME-Version: 1.0
Message-ID: <868058.36595.qm@web92202.mail.cnh.yahoo.com>
Subject: [uml-devel] Debug under Skas3 start_uml - start_userspace returned -22
Reply-To: foolishzhu@yahoo.cn
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6926045283688810870=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============6926045283688810870==
Content-Type: multipart/alternative; boundary="0-1113773276-1227417199=:36595"

--0-1113773276-1227417199=:36595
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

HI
All
I have patched my linux host for ska3 and it can run under skas3 mode. Howe=
ver, when I gdb linux
i. I want to follow=20
r
ubd0=3D/home/jdike/roots/cow.debian,/home/jdike/roots/debian_22
con=3Dport:9000 ssl=3Dpty con0=3Dfd:0,fd:1 umid=3Ddebian mem=3D128M

however, I do not the meaning of ubd0 ,since there is no cow.debian under m=
y roots. I really do not know how to set these parameters.

So , I just put (after setting handle two signals)
r=20
It comes out
Starting program: ~/linux-2.6.27.6/linux=20
Locating the bottom of the address space ... 0x0
Locating the top of the address space ... 0xc0000000
Core dump limits :
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soft - 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
=C2=A0 - /proc/mm...found
=C2=A0 - PTRACE_FAULTINFO...found
=C2=A0 -
 PTRACE_LDT...found
UML running in SKAS3 mode
[New LWP 7387]
[LWP 7387 exited]
start_uml - start_userspace returned -22

IS there anyone can help me?
thankyou
=C2=A0
=0A=0A=0A      ___________________________________________________________ =
=0A  =E5=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=BC=
=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=BF=
=EF=BC=81 =0Ahttp://card.mail.cn.yahoo.com/
--0-1113773276-1227417199=:36595
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><div id=3D"yiv1532780175">HI<br>All<br>I have=
 patched my linux host for ska3 and it can run under skas3 mode. However, w=
hen I gdb linux<br>i. I want to follow <br><tt><font color=3D"#000000">r
ubd0=3D/home/jdike/roots/cow.debian,/home/jdike/roots/debian_22
con=3Dport:9000 ssl=3Dpty con0=3Dfd:0,fd:1 umid=3Ddebian mem=3D128M<br><br>=
however, I do not the meaning of ubd0 ,since there is no cow.debian under m=
y roots. I really do not know how to set these parameters.<br><br>So , I ju=
st put (after setting handle two signals)<br>r <br>It comes out<br>Starting=
 program: ~/linux-2.6.27.6/linux <br>Locating the bottom of the address spa=
ce ... 0x0<br>Locating the top of the address space ... 0xc0000000<br>Core =
dump limits :<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft - 0<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hard - NONE<br>Checking that ptrace=
 can change system call numbers...OK<br>Checking syscall emulation patch fo=
r ptrace...OK<br>Checking advanced syscall emulation patch for ptrace...OK<=
br>Checking for tmpfs mount on /dev/shm...OK<br>Checking PROT_EXEC mmap in =
/dev/shm/...OK<br>Checking for the skas3 patch in the host:<br>&nbsp; - /pr=
oc/mm...found<br>&nbsp; - PTRACE_FAULTINFO...found<br>&nbsp; -
 PTRACE_LDT...found<br>UML running in SKAS3 mode<br>[New LWP 7387]<br>[LWP =
7387 exited]<br>start_uml - start_userspace returned -22<br><br>IS there an=
yone can help me?<br>thankyou<br>&nbsp;<br></font></tt></div></td></tr></ta=
ble><br>=0A=0A=0A      <hr size=3D1><a href=3D"http://cn.rd.yahoo.com/mail_=
cn/tagline/card/*http://card.mail.cn.yahoo.com/">  =E5=A5=BD=E7=8E=A9=E8=B4=
=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=BC=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=
=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=BF=EF=BC=81</a>
--0-1113773276-1227417199=:36595--


--===============6926045283688810870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============6926045283688810870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6926045283688810870==--

