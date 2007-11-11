Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IrJHJ-0006Yq-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Nov 2007 12:19:33 -0800
Received: from swingline.cs.wisc.edu ([128.105.121.52])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IrJHI-0002V9-4j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Nov 2007 12:19:33 -0800
Date: Sun, 11 Nov 2007 13:47:16 -0600
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20071111194711.GA16100@swingline.cs.wisc.edu>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
	<20071102155131.GB5760@c2.user-mode-linux.org>
	<20071102162239.GA13481@swingline.cs.wisc.edu>
	<20071105171213.GA7296@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071105171213.GA7296@c2.user-mode-linux.org>
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

On Mon, Nov 05, 2007 at 12:12:13PM -0500, Jeff Dike wrote:
> On Fri, Nov 02, 2007 at 11:22:44AM -0500, Erik Paulson wrote:
> > running:
> > make linux ARCH=um CFLAGS=-I/scratch/epaulson/vde/include
> 
> This isn't going to help with the compilation problems, but the patch
> below seems to pass LFLAGS from the command line through to ld nicely.
> 
> >   CC      arch/um/kernel/skas/mmu.o
> > In file included from include/asm/processor-generic.h:13,
> >                  from include/asm/processor.h:77,
> >                  from include/asm/thread_info.h:11,
> >                  from include/linux/thread_info.h:21,
> >                  from include/linux/preempt.h:9,
> >                  from include/linux/spinlock.h:49,
> >                  from include/linux/mmzone.h:7,
> >                  from include/linux/gfp.h:4,
> >                  from include/linux/mm.h:8,
> >                  from arch/um/kernel/skas/mmu.c:6:
> > include/asm/ptrace.h:50: warning: "struct user_fxsr_struct" declared inside parameter list
> > include/asm/ptrace.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
> > include/asm/ptrace.h:52: warning: "struct user_fxsr_struct" declared
> > inside parameter list
> 
> Does this happen with plain old defconfig?
> 
> 				Jeff

Good news - this doesn't happen with 2.6.24-rc2. defconfig builds with
a CFLAGS on the commandline

Unfortunately, VDE still doesn't compile - the CFLAGS aren't being passed 
along to arch/um/drivers:

make linux ARCH=um CFLAGS=-I/scratch/epaulson/vde/include LDFLAGS=-L/scratch/epaulson/vde/lib V=1

<...>
make -f scripts/Makefile.build obj=arch/um/drivers
  gcc -Wp,-MD,arch/um/drivers/.vde_user.o.d  -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -D__arch_um__ -DSUBARCH=\"i386\" -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback -Din6addr_any=kernel_in6addr_any -DCONFIG_X86_32 -march=i686 -mpreferred-stack-boundary=2 -ffreestanding -D_LARGEFILE64_SOURCE  -fno-unit-at-a-time -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Iarch/um/include -I/scratch/epaulson/uml/linux-2.6.24-rc2/linux-2.6.23/arch/um/include/skas -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE  -c -o arch/um/drivers/vde_user.o arch/um/drivers/vde_user.c
arch/um/drivers/vde_user.c:8:24: libvdeplug.h: No such file or directory



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
