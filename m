Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfTv0-0003XE-Q0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:38:50 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FfTv0-0005Wp-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:38:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FfTuz-0003WY-Bv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 May 2006 20:38:50 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on
	x86-64
Message-ID: <20060515033919.GD21383@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514182541.GA4980@gmail.com>
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
Date: Sun, 14 May 2006 23:39:19 -0400
To: Alberto Bertogli <albertito@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
> on. Probably, the same happens under i386.

The current patch for this is http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf

I need to redo it, but that works for now.

> Then, it built fine, but at the end several errors showed up:
>   MODPOST
> WARNING: vmlinux - Section mismatch: reference to .init.text:do_mount_root from .bss between '__guard@@GLIBC_2.3.2' (at offset 0x603c5688) and 'stdout@@GLIBC_2.2.5'

I have no idea what these mean, but they seem not to affect the
viability of the resulting kernel.

> It begins to boot, but panics right after mounting root:
> 
> [42949373.800000] kjournald starting.  Commit interval 5 seconds
> [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943

This is a segfault happening when it shouldn't.

Can you disassemble stub_segv_handler and send me the output?  If
you're unfamiliar with gdb, it works like this:

	% gdb linux
	GNU gdb Red Hat Linux (6.3.0.0-1.122rh)
	Copyright 2004 Free Software Foundation, Inc.
	GDB is free software, covered by the GNU General Public License, and you are
	welcome to change it and/or distribute copies of it under certain conditions.
	Type "show copying" to see the conditions.
	`There is absolutely no warranty for GDB.  Type "show warranty" for details.
	This GDB was configured as "x86_64-redhat-linux-gnu"...Using host libthread_db library "/lib64/libthread_db.so.1".
	
	(gdb) disas stub_segv_handler
	Dump of assembler code for function stub_segv_handler:
	0x00000000601610c8 <stub_segv_handler+0>:       push   %rbp
	0x00000000601610c9 <stub_segv_handler+1>:       mov    %rsp,%rbp
	0x00000000601610cc <stub_segv_handler+4>:       mov    %rdx,%r8
	...

There was a bug like this a month or so ago, but it has been in
mainline for a while, so this should be something different.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
