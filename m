Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXANx-0002yM-Ji
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 18:29:01 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXANx-0004vE-AF
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 18:29:01 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
Message-ID: <20031219022854.GW18100@alcor.net>
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz> <20031219002949.GX18100@alcor.net> <20031219014756.GC4945@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219014756.GC4945@ccure.user-mode-linux.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 18:28:54 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Srdjan <srdjan@catalyst.net.nz>, 224431-forwarded@bugs.debian.org

On Thu, Dec 18, 2003 at 08:47:56PM -0500, Jeff Dike wrote:

> On Thu, Dec 18, 2003 at 04:29:49PM -0800, Matt Zimmerman wrote:
> > Apparently, tt mode is broken.  I use skas, which is working fine in
> > 2.4.22-7um-1, but I can reproduce your failure with mode=tt.
> 
> Hmmm, I can't.  It seems fine here.
> 
> Can you run it with 'debug' and get a stack trace from the hang?

Unfortunately, unstable recently received gdb 6.0, and 'debug' no longer
works.

GNU gdb 6.0-debian
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...(no debugging symbols found)...
[hangs here indefinitely; gdb is suspended]
mdz      15970  0.0  0.4  5956 2576 pts/12   S    18:19   0:00 gdb --command /tm
mdz      15971  0.0  0.4  5956 2576 pts/12   T    18:19   0:00 gdb --command /tm

sending a SIGCONT to the suspended gdb process results in:

0xa01502b1 in ?? ()
/tmp/gdb_init-cJnGax:2: Error in sourced command file:
No symbol table is loaded.  Use the "file" command.
(gdb) 

(line 2 of the sourced command file is 'b panic')

It still seems to work to run UML inside gdb manually, though.  Here's the
backtrace:

(gdb) bt
#0  0xa016619d in waitpid ()
    at /space/tmp/mdz/debian/work/user-mode-linux/user-mode-linux-2.4.22-7um/kernel-source-2.4.22/include/linux/proc_fs.h:158
#1  0x00005261 in ?? ()
#2  0xa00c17b0 in tracer (init_proc=0xa00c03b0 <start_kernel_proc>, 
    sp=0xa01f3ffc) at tracer.c:236
#3  0xa00c04de in start_uml_tt () at process_kern.c:500
#4  0xa00bebc5 in linux_main (argc=7, argv=0xbffff684) at um_arch.c:387
#5  0xa000d3c1 in main (argc=7, argv=0xbffff684, envp=0xbffff6a4)
    at arch/um/main.c:146

In my case, the host kernel is 2.4.21 with skas3.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
