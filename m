Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP70s-0001Tg-Mf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 14:20:26 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CP70r-0007LP-Oo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 14:20:26 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Stop at startup on 2.6 NPTL hosts (was: Re: [uml-devel] UML Kernel
	2.6.7 Nothing happens)
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
In-Reply-To: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200411021952.09095.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Tue, 2 Nov 2004 19:52:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

On Friday 29 October 2004 11:26, Roland Kaeser wrote:
> Hi all

> I'm a newby to UML but an very oldy to linux. I want to try to setup up
> several uml jailed services on one physical machine.

> I'm using Kernel 2.6.7 with Host SKS patch and also Kernel 2.6.7 for the
> uml instances. I'm calling the uml kernel but then nothing happens:

> root@roland linux]# /install/uml/kernel/linux
> initrd=/install/uml/files/initrd.img lang= devfs=nomount ramdisk_size=10240
> mem=128M eth0=tuntap,,,195.49.21.28 ubd0=/install/uml/instances/fc2install
> fakehd con=xterm ubd=0
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found

> [1]+  Stopped                 /install/uml/kernel/linux
> initrd=/install/uml/files/initrd.img lang= devfs=nomount ramdisk_size=10240
> mem=128M eth0=tuntap,,,195.49.21.28 ubd0=/install/uml/instances/fc2install
> fakehd con=xterm ubd=0

> I've made the nodes in /dev/ compiled and installed the uml utilities. I
> really have no idea whats wrong.
> Please help

I'm CC:ing everybody who I found reported this problem. And with this problem, 
I mean this:

$ ./vmlinux ubd0=~/Uml/root_fs_toms1.7.205
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found

[1]+  Stopped                 ./vmlinux ubd0=~/Uml/root_fs_toms1.7.205

I'm experiencing this problem, too, so I'm trying to fix it. I'm getting some 
success, but I'll have to fix a lot of places before UML start working again.

I have found out what happens. I simply ran:
gdb ./vmlinux
r
bt
and went watching the source in the backtrace point.

This happens if and only if UML is using NPTL thread libraries. This, in turn, 
happens in normal config with a NPTL-enabled glibc on the host, or in the 
special situation of CONFIG_MODE_TT and CONFIG_STATIC_LINK off. This is why 
it's not normally noticed and it's not yet debugged (it was reported the 1st 
time by Nuno Silva around 2.6.0).

Usually compiling with CONFIG_MODE_TT enabled appears to workaround the 
problem on most distros. The exception are Gentoo and recent LinuxFromScratch 
systems, where it would cause the compilation to fail.

It is one UML bug I've just identified and that I'm trying to fix. This is the 
faulty code, from arch/um/kernel/skas/process.c:

static int userspace_tramp(void *arg)
{
        init_new_thread_signals(0);
        enable_timer();
        ptrace(PTRACE_TRACEME, 0, 0, 0);
        tkill(gettid(), SIGSTOP);
        os_stop_process(os_getpid());
        return(0);
}

This is executed by a clone() child. What happens is that, with NPTL, both the 
father and the son have the same pid, so the SIGSTOP is routed to the wrong 
thread. However, this is not expected: having the same pid should be reserved 
to when clone is called with CLONE_THREAD in the flags. I've verified that 
this is not happening in this case, even with strace (to make sure glibc is 
not playing any dirty tricks). But for some reasons, the kernel is behaving 
as if this happened.

What makes me suspicious is that the NPTL library calls set_thread_area(). 
Even by checking the source, it should not interfere. But something wrong may 
be happening.

Best regards.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
