Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiJG4-0007KE-7v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 13:43:12 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BiJG3-00014K-RY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 13:43:12 -0700
Received: from SCG2 (dyn170.CONET.OUS.EDU [140.211.15.170])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 1CF2C2A3A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  7 Jul 2004 13:43:10 -0700 (PDT)
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: RE: [uml-devel] uml_mconsole issue
Message-ID: <IFEIKNDOLFNCKMGAENCFEEIECHAA.Anthony_Brock@ous.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <200407071914.06387.blaisorblade_spam@yahoo.it>
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
Date: Wed, 7 Jul 2004 13:43:07 -0700
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Okay, I think I have it. I shouldn't have issued the "handle SIGSEGV..."
command. This backtrace was generated on Kernel 2.6.7 during the 5th time I
issuing the following command on the host:

uml_mconsole bind2 proc uptime

*** BEGIN BACKTRACE ***
dns2 login:
Program received signal SIGSEGV, Segmentation fault.
0xa00730df in link_path_walk (name=3D0xa0a59ca9 "uptime", nd=3D0xa3fd3aa4) =
at
fs/namei.c:591
591                     lookup_flags =3D LOOKUP_FOLLOW;
(gdb) bt
#0  0xa00730df in link_path_walk (name=3D0xa0a59ca9 "uptime", nd=3D0xa3fd3a=
a4)
at fs/namei.c:591
#1  0xa00227de in mconsole_proc (req=3D0xa0a59c08) at
arch/um/drivers/mconsole_kern.c:152
#2  0xa0022584 in mc_work_proc (unused=3D0x0) at
arch/um/drivers/mconsole_kern.c:67
#3  0xa004162c in worker_thread (__cwq=3D0xa039084c) at kernel/workqueue.c:=
172
#4  0xa00448dc in kthread (_create=3D0xa3fdfb14) at kernel/kthread.c:90
#5  0xa00154da in run_kernel_thread (fn=3D0xa0044850 <kthread>,
arg=3D0xa3fdfb14, jmp_ptr=3D0x0) at arch/um/kernel/process.c:294
#6  0xa001f6ac in new_thread_handler (sig=3D10) at
arch/um/kernel/skas/process_kern.c:130
#7  <signal handler called>
#8  0xa01e305d in syscall () at slab.h:92
#9  0x00000000 in ?? ()
#10 0x00000000 in ?? ()
#11 0x00000000 in ?? ()
#12 0x00000000 in ?? ()
#13 0x00000000 in ?? ()
#14 0x00000000 in ?? ()
#15 0x00000000 in ?? ()
#16 0x00000000 in ?? ()
#17 0x00000000 in ?? ()
#18 0x00000000 in ?? ()
#19 0x00000000 in ?? ()
#20 0x00000000 in ?? ()
#21 0x00000000 in ?? ()
#22 0x00000000 in ?? ()
#23 0x00000000 in ?? ()
#24 0xa01caca4 in sigemptyset (set=3D0x0) at sigempty.c:34
Previous frame inner to this frame (corrupt stack?)
(gdb) c
Continuing.

Breakpoint 1, panic (fmt=3D0xa0224f96 "Segfault with no mm") at
kernel/panic.c:58
58              bust_spinlocks(1);
(gdb) c
Continuing.
Kernel panic: Segfault with no mm


Program exited with code 01.
(gdb) c
The program is not being run.
(gdb) quit
$
*** END BACKTRACE ***

Hope this helps!

Tony

> -----Original Message-----
> From: BlaisorBlade [mailto:blaisorblade_spam@yahoo.it]
> Sent: Wednesday, July 07, 2004 10:14 AM
> To: Anthony Brock; user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] uml_mconsole issue
>
>
> Alle 07:14, mercoled=EC 7 luglio 2004, Anthony Brock ha scritto:
> > Let me know if you require more detail and what specific steps I should
> > take to help trouble-shoot this. Thanks in advance!
> Could you try taking a "backtrace" from the UML? I've no time for now to
> explain it, but it has been explained tons of times on this ML...
> search for
> "backtrace" on the marc.theaimsgroup.com archives! See also the
> "debugging
> kernel" page (the subsection about skas).
> --
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
>
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
