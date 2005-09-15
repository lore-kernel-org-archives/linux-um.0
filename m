Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG0OF-0008Pn-LZ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:31:27 -0700
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG0OE-00007d-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:31:27 -0700
Received: by zproxy.gmail.com with SMTP id i11so395489nzh
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Sep 2005 13:31:19 -0700 (PDT)
Message-ID: <838f7c5005091513317a6166c0@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Reply-To: ashwin.tanugula@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25282_29466691.1126816279469"
Subject: [uml-devel] UML compile errors for 2.6.10 kernel
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
Date: Thu, 15 Sep 2005 16:31:19 -0400
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_25282_29466691.1126816279469
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I got the following errors when I tried to compile a 2.6.10 kernel. What=20
should I do to fix this?

root@slemieux:/home/ashwin/Desktop/2610/linux-2.6.10 # make linux ARCH=3Dum
CHK include/linux/version.h
UPD include/linux/version.h
SYMLINK include/asm -> include/asm-um
SPLIT include/linux/autoconf.h -> include/config/*
SYMLINK arch/um/include/sysdep
SYMLINK arch/um/os
SYMLINK include/asm-um/archparam.h
SYMLINK include/asm-um/system.h
SYMLINK include/asm-um/sigcontext.h
SYMLINK include/asm-um/processor.h
SYMLINK include/asm-um/ptrace.h
SYMLINK include/asm-um/arch-signal.h
SYMLINK include/asm-um/module.h
CHK arch/um/include/uml-config.h
UPD arch/um/include/uml-config.h
make: *** No rule to make target `arch/um/include/sysdep-ppc/sc.h', needed=
=20
by `arch/um/util'. Stop.


Thanks,
Ashwin

------=_Part_25282_29466691.1126816279469
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
I got the following errors when I tried to compile a 2.6.10 kernel. What sh=
ould I do to fix this?<br>
<br>
root@slemieux:/home/ashwin/Desktop/2610/linux-2.6.10 # make linux ARCH=3Dum=
<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>
&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>
&nbsp; SYMLINK include/asm -&gt; include/asm-um<br>
&nbsp; SPLIT&nbsp;&nbsp; include/linux/autoconf.h -&gt; include/config/*<br=
>
&nbsp; SYMLINK arch/um/include/sysdep<br>
&nbsp; SYMLINK arch/um/os<br>
&nbsp; SYMLINK include/asm-um/archparam.h<br>
&nbsp; SYMLINK include/asm-um/system.h<br>
&nbsp; SYMLINK include/asm-um/sigcontext.h<br>
&nbsp; SYMLINK include/asm-um/processor.h<br>
&nbsp; SYMLINK include/asm-um/ptrace.h<br>
&nbsp; SYMLINK include/asm-um/arch-signal.h<br>
&nbsp; SYMLINK include/asm-um/module.h<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>
&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>
make: *** No rule to make target `arch/um/include/sysdep-ppc/sc.h', needed =
by `arch/um/util'.&nbsp; Stop.<br>
<br>
<br>
Thanks,<br>
Ashwin<br>

------=_Part_25282_29466691.1126816279469--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
