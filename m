Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <david.francisco.rodriguez@gmail.com>)
	id 1NYTGQ-0004T2-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Jan 2010 23:50:06 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYTGP-0001EG-TR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Jan 2010 23:50:06 +0000
Received: by yxe40 with SMTP id 40so1449308yxe.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 22 Jan 2010 15:50:00 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 22 Jan 2010 15:49:55 -0800
Message-ID: <d875c4ca1001221549t211b2821x3ba36d1cea28de65@mail.gmail.com>
From: David Francisco Rodriguez Perez <david.francisco.rodriguez@gmail.com>
Subject: [uml-devel] segfault on 2.6.32.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7226906367487548978=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============7226906367487548978==
Content-Type: multipart/alternative; boundary=0016364ed934fbd726047dc97969

--0016364ed934fbd726047dc97969
Content-Type: text/plain; charset=ISO-8859-1

Hi All

I have been using UML with kernel 2.6.29.6 it was working okay. I move up to
2.6.32.4.
I started using 2.6.32.4  using ARCH=um and I getting SIGSEGV similar to the
thread below:

http://groups.google.com/group/linux.kernel/browse_thread/thread/9f921f62fff75f6f?pli=1

The problem happens if I configure the kernel menu option :
Force a static link
which compiles the vmlinux staticly. If I don't use that option the vmlinux
boots okay

The error is like

(gdb) b main
Breakpoint 1 at 0x804bd54: file
/home/darodrig/PERFORCE/7.1.1.R01-darodrig-v3/engr/sw/tps/installed/23/rushmore_sim/kernel/ksrc/arch/um/os-Linux/main.c,
line 126.
(gdb) r
Starting program:
/home/darodrig/PERFORCE/7.1.1.R01-darodrig-v3/engr/sw/tps/objs/23/rushmore_sim/image/vmlinux
mem=256M

Program received signal SIGSEGV, Segmentation fault.
__libc_setup_tls (tcbsize=1136, tcbalign=16) at libc-tls.c:125
125     libc-tls.c: No such file or directory.
        in libc-tls.c

I wonder if somebody knows about it ? and what to do?

Thanks,

David Rodriguez

--0016364ed934fbd726047dc97969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All<br><br>I have been using UML with kernel 2.6.29.6 it was working oka=
y. I move up to 2.6.32.4.<br>I started using 2.6.32.4=A0 using ARCH=3Dum an=
d I getting SIGSEGV similar to the thread below:<br><br><a href=3D"http://g=
roups.google.com/group/linux.kernel/browse_thread/thread/9f921f62fff75f6f?p=
li=3D1">http://groups.google.com/group/linux.kernel/browse_thread/thread/9f=
921f62fff75f6f?pli=3D1</a><br>
<br>The problem happens if I configure the kernel menu option :<br>Force a =
static link<br>which compiles the vmlinux staticly. If I don&#39;t use that=
 option the vmlinux boots okay<br><br>The error is like <br><br>(gdb) b mai=
n<br>
Breakpoint 1 at 0x804bd54: file /home/darodrig/PERFORCE/7.1.1.R01-darodrig-=
v3/engr/sw/tps/installed/23/rushmore_sim/kernel/ksrc/arch/um/os-Linux/main.=
c, line 126.<br>(gdb) r<br>Starting program: /home/darodrig/PERFORCE/7.1.1.=
R01-darodrig-v3/engr/sw/tps/objs/23/rushmore_sim/image/vmlinux mem=3D256M<b=
r>
<br>Program received signal SIGSEGV, Segmentation fault.<br>__libc_setup_tl=
s (tcbsize=3D1136, tcbalign=3D16) at libc-tls.c:125<br>125=A0=A0=A0=A0 libc=
-tls.c: No such file or directory.<br>=A0=A0=A0=A0=A0=A0=A0 in libc-tls.c<b=
r><br>I wonder if somebody knows about it ? and what to do?<br>
<br>Thanks,<br><br>David Rodriguez<br>

--0016364ed934fbd726047dc97969--


--===============7226906367487548978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============7226906367487548978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7226906367487548978==--


