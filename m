Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APTH1-0004kx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 13:02:03 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APTH0-0001yw-L0
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 13:02:02 -0800
Message-ID: <002101c3b52a$4a42ede0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <5.1.0.14.2.20031127102518.02675b90@mail.inboxprotection.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] uml 2.6.0-test9 crash
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
Date: Thu, 27 Nov 2003 22:06:01 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

hi !=B4
i think , i`m able to crash my uml. :(

i did some stress-testing with my uml-2.6.0-test9 on 2.6.0-test9-skas host =
and i
unfortunately seem able to crash it very easily.

this was the way i recognized it:
first i executed
while true;do find /;done >/dev/zero &
several times and all worked well.
watched that with "top" inside the uml and found dozens of "finds" sharing =
the
cpu as expected(spending most of their time on system calls indeed).
on host, cpu usage of uml went to ~99% - all fine so far.

then i thought: mhhhh - ok - eat THIS:
while true;do dd if=3D/dev/zero of=3Dtest.dat bs=3D1k count=3D10000;done &

after executing this, my uml got stuck. no output, no response to input - e=
ven a
ping to the uml didn`t=B4give back a sign of life. the uml didn`t crash or =
panic - it
just gets stuck and unresponsive - uml process remains at 99% on the host.

at a second, third, fourth try, i isolated the problem a little bit:
one or two non looped "dd if=3D/dev/zero of=3Dtest.dat bs=3D1k count=3D1000=
0" just are enough
to produce the same result.(under 2.6.0test9-skas-host and ALSO under 2.4.2=
2-99-default
suse9 host, rootfs inside uml is suse9)

is anybody able to reproduce this?
if so - what do do further for analyzing?
i could make the uml downloadable and could send some output from strace (i=
f i attach strace
to the remaining "99% cpu hog", it exits very quickly with a SIGALARM)

maybe an uml bug or even an issue for lkml?

regards
roland



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
