Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AK6ka-0003Hb-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 17:58:24 -0800
Received: from blabluga.hell.pl ([62.121.102.27] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AK6kZ-0002zn-St
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 12 Nov 2003 17:58:24 -0800
From: "Artur R. Czechowski" <arturcz@hell.pl>
Message-ID: <20031113015758.GS22490@blabluga.hell.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Subject: [uml-devel] UML on 2.6.0-test9 host
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 13 Nov 2003 02:57:58 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hello,
I would like to exercise a benefits from user-mode-linux, so I installed it
and... the saga begins.

I am using Debian unstable, kernel 2.6.0-test9 and debianized
user-mode-linux, version 2.4.22-5um-1. It looks like running uml in this
configuration is impossible. However it boots properly after some time it
displays message:
I'm tracing myself and I can't get out
and it hangs up.
Only I can do is ``killall linux''.

I have tried to debug it, but none of method described in debugging.html
works. Only results I received comes from:

arturcz@blabluga:~$ linux con0=3Dfd:0,fd:1 con=3Dpty ubd1=3Duml-image  devf=
s=3Dmount
rsworkdir=3D/home/arturcz root=3D/dev/root rootflags=3D/ rootfstype=3Dhostfs
init=3D/bin/bash debugtrace
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 20743
Tracing thread pausing to be attached

arturcz@blabluga:~$ gdb /usr/bin/linux
GNU gdb 6.0-debian
[copyright]
This GDB was configured as "i386-linux"...(no debugging symbols found)...
(gdb) att 20743
Attaching to program: /usr/bin/linux, process 20743
0xa01b5f9a in ?? ()
(gdb) bt
#0  0xa01b5f9a in ?? ()
#1  0xa01b5e43 in ?? ()
#2  0xa00f220d in ?? ()
#3  0x000f4240 in ?? ()
#4  0xa0203f60 in ?? ()
#5  0xbffff3f4 in ?? ()
#6  0xa00f491e in ?? ()
#7  0x0000000a in ?? ()
#8  0xa00f2a70 in ?? ()
#9  0xbffff438 in ?? ()
#10 0xa00f493c in ?? ()
#11 0xa0203f60 in ?? ()
#12 0xa00f46a0 in ?? ()
(gdb)=20

and linux is still hanged up.

giving cont command to gdb results only with:
(gdb) c
Continuing.

That's all what I can tell you about this problem. If you need any other
data (like host's kernel configuration, used libraries, etc) send me an
email.

Thanks for your attention.

Cheers
	Artur

PS. Please CC me on reply, I'm not subscribed here.
--=20
Jak trwoga to do serwisu
	/z pami=EAtnika administratora/


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
