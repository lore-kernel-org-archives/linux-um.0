Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InzIH-0006Aj-OS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 09:22:50 -0700
Received: from swingline.cs.wisc.edu ([128.105.121.52])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1InzIF-0007Fk-Cu
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 09:22:47 -0700
Date: Fri, 2 Nov 2007 11:22:44 -0500
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20071102162239.GA13481@swingline.cs.wisc.edu>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
	<20071102155131.GB5760@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071102155131.GB5760@c2.user-mode-linux.org>
Subject: Re: [uml-devel] building 2.6.24-rc1 with VDE in a non-standard
	location?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 02, 2007 at 11:51:31AM -0400, Jeff Dike wrote:
> On Thu, Nov 01, 2007 at 09:27:49PM -0500, Erik Paulson wrote:
> > I'm trying to build UML with VDE support turned on. However, I don't
> > have root on my host machine, so when I installed VDE I put it in a 
> > non-standard location. 
> > 
> > How do you pass extra -L and -I flags to the kernel build process? I
> > tried adding
> > 
> > make linux ARCH=um CFLAGS=-I/path/to/my/vde/include 
> > with no go, and I tried adding the include path to
> > HOSTCFLAGS in the top level Makefile rules, but that also didn't
> > work.
> 
> How recent a kernel tree are you playing with?  This patch seems to do
> what you want for CFLAGS -
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=52bcc3308ae3344266f55bf98a22c1ac0201eda7
> 

2.6.24-rc1 (2.6.23 plus the patch for rc1, plus the patch you mentioned on
the 25th:
   http://marc.info/?l=linux-kernel&m=119332492222601&q=raw

With basically just using 'defconfig' (I turned on VDE, but otherwise touched
nothing in menuconfig).

I used:
swingline(10)% gcc -v
Reading specs from /usr/lib/gcc/i386-redhat-linux/3.4.6/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-java-awt=gtk --host=i386-redhat-linux
Thread model: posix
gcc version 3.4.6 20060404 (Red Hat 3.4.6-8)

running:
make linux ARCH=um CFLAGS=-I/scratch/epaulson/vde/include

I get:
<the below error message repeated many times>
  CC      arch/um/kernel/skas/mmu.o
In file included from include/asm/processor-generic.h:13,
                 from include/asm/processor.h:77,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:4,
                 from include/linux/mm.h:8,
                 from arch/um/kernel/skas/mmu.c:6:
include/asm/ptrace.h:50: warning: "struct user_fxsr_struct" declared inside parameter list
include/asm/ptrace.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
include/asm/ptrace.h:52: warning: "struct user_fxsr_struct" declared inside parameter list
In file included from include/linux/timer.h:5,
                 from include/linux/sched.h:87,
                 from include/asm/pgtable.h:11,
                 from include/linux/mm.h:37,
                 from arch/um/kernel/skas/mmu.c:6:
include/linux/ktime.h: In function `ktime_set':
include/linux/ktime.h:84: warning: comparison is always false due to limited range of data type
/tmp/cc8wIDJP.s: Assembler messages:
/tmp/cc8wIDJP.s:485: Error: suffix or operands invalid for `dec'
/tmp/cc8wIDJP.s:496: Error: suffix or operands invalid for `dec'
make[2]: *** [arch/um/kernel/skas/mmu.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

I'll try rc1-git11 this afternoon.

-Erik


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
