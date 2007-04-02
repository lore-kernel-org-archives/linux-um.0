Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYSyi-0007YA-4K for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 13:18:12 -0700
Received: from fmmailgate01.web.de ([217.72.192.221])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYSyg-0004eB-7U
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 13:18:12 -0700
Message-ID: <001f01c77564$86416300$eeeea8c0@aldipc>
From: "roland" <devzero@web.de>
References: <20070402165012.GA7626@c2.user-mode-linux.org>
Date: Mon, 2 Apr 2007 22:21:38 +0200
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/4] UML - kernel_thread shouldn't panic
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

i=B4d like to acknowledge that this fixes the problem i had when creating=20
loop-devices inside uml.

instead of crashing the whole uml, losetup now tells:

ioctl: LOOP_SET_FD: Resource temporarily unavailable

and dmesg:

Apr  2 20:17:53 localhost udevd[641]: udev_event_run: fork of child failed:=
=20
Resource temporarily unavailable
Apr  2 20:17:54 localhost last message repeated 4 times
Apr  2 20:17:54 localhost udevd-event[3014]: run_program: fork of=20
'/lib/udev/udev_run_hotplugd' failed:Resource temporarily unavailable
Apr  2 20:17:54 localhost udevd-event[3014]: run_program: fork of=20
'/lib/udev/udev_run_devd' failed: Resource temporarily unavailable
Apr  2 20:17:54 localhost udevd-event[3014]: run_program: fork of=20
'/sbin/pam_console_apply' failed: Resource temporarily unavailable
Apr  2 20:17:54 localhost udevd[641]: udev_event_run: fork of child failed:=
=20
Resource temporarily unavailable

so, this should be right behaviour now when running out of memory.

regards
roland

----- Original Message -----=20
From: "Jeff Dike" <jdike@addtoit.com>
To: "Andrew Morton" <akpm@osdl.org>; <devzero@web.de>
Cc: "LKML" <linux-kernel@vger.kernel.org>; "uml-devel"=20
<user-mode-linux-devel@lists.sourceforge.net>
Sent: Monday, April 02, 2007 6:50 PM
Subject: [PATCH 4/4] UML - kernel_thread shouldn't panic


> kernel_thread should just return an error value on do_fork failure, not=20
> panic.
>
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
> arch/um/kernel/process.c |    2 --
> 1 file changed, 2 deletions(-)
>
> Index: linux-2.6.21-mm/arch/um/kernel/process.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-mm.orig/arch/um/kernel/process.c 2007-04-02=20
> 11:51:43.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/kernel/process.c 2007-04-02=20
> 12:01:00.000000000 -0400
> @@ -97,8 +97,6 @@ int kernel_thread(int (*fn)(void *), voi
>  current->thread.request.u.thread.arg =3D arg;
>  pid =3D do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0,
>        &current->thread.regs, 0, NULL, NULL);
> - if(pid < 0)
> - panic("do_fork failed in kernel_thread, errno =3D %d", pid);
>  return pid;
> }
>=20


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

