Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V9DKf-0002TB-Rc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 12:04:13 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V9DKe-0007xL-Cj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 12:04:13 +0000
Date: Tue, 13 Aug 2013 13:04:01 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130813120401.GE10864@redhat.com>
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
	<20130812085300.GV5918@redhat.com>
	<20130813103603.GA27173@redhat.com> <520A0F35.8000905@nod.at>
	<20130813110651.GX5918@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130813110651.GX5918@redhat.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] How to reliably kill all vmlinux processes for a
 single VM?
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


OK, I understand what's going wrong and how to reproduce the
signal-to-parent problem.  It does look like a bug in vmlinux.

It happens if the init process (PID 1) inside the VM gets a segfault.

In libguestfs we can force that easily, as there is a test path for
exercising segfaults in our init process:

----------------------------------------------------------------------
#!/bin/bash -
export LIBGUESTFS_BACKEND=uml
export LIBGUESTFS_QEMU=/home/rjones/d/linux/vmlinux
export LIBGUESTFS_DEBUG=1
export LIBGUESTFS_TRACE=1
./run strace -o /tmp/strace.log ./fish/guestfish -a /dev/null <<EOF
run
get-pid
debug segv 1
!sleep 5
EOF
----------------------------------------------------------------------

The output of this and the strace log file is here:

http://oirase.annexia.org/tmp/uml-signal/

output.log.txt shows the PID of vmlinux is 6856.

strace.log.txt shows that the parent process gets terminated by
SIGTERM *from* PID 6856:

--- SIGTERM {si_signo=SIGTERM, si_code=SI_USER, si_pid=6856, si_uid=1000} ---
+++ killed by SIGTERM +++

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

