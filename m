Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pbutler@pt.com>) id 1UOIq2-0003w9-I5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 02:26:42 +0000
Received: from ottgw.pt.com ([209.217.107.194])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UOIpz-00071f-Ta for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 02:26:42 +0000
Message-ID: <39656.10.100.142.174.1365215174.squirrel@webmail3.pt.com>
In-Reply-To: <20130405161541.6e4a2472@spider.haslach.nod.at>
References: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
	<20130405092141.61f2f61c@spider.haslach.nod.at>
	<OFF553D1A8.B32C41CE-ON85257B44.004D6DD3-85257B44.004D81FA@pt.com>
	<20130405160739.68d74008@spider.haslach.nod.at>
	<OF04169121.A123E516-ON85257B44.004E1BE5-85257B44.004E21A8@pt.com>
	<20130405161541.6e4a2472@spider.haslach.nod.at>
Date: Fri, 5 Apr 2013 22:26:14 -0400 (EDT)
From: "Peter Butler" <pbutler@pt.com>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] BUG: failure at
 block/blk-core.c:2985/blk_flush_plug_list()
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Looks like the mainline fails early in the build process (?)

after 'make mrproper' and 'make defconfig' I get this:

bash $ make ARCH=um linux
scripts/kconfig/conf --silentoldconfig arch/x86/um/Kconfig
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  WRAP    arch/um/include/generated/asm/bug.h
  WRAP    arch/um/include/generated/asm/cputime.h
  WRAP    arch/um/include/generated/asm/device.h
  WRAP    arch/um/include/generated/asm/emergency-restart.h
  WRAP    arch/um/include/generated/asm/futex.h
  WRAP    arch/um/include/generated/asm/hardirq.h
  WRAP    arch/um/include/generated/asm/hw_irq.h
  WRAP    arch/um/include/generated/asm/irq_regs.h
  WRAP    arch/um/include/generated/asm/kdebug.h
  WRAP    arch/um/include/generated/asm/percpu.h
  WRAP    arch/um/include/generated/asm/sections.h
  WRAP    arch/um/include/generated/asm/topology.h
  WRAP    arch/um/include/generated/asm/xor.h
  WRAP    arch/um/include/generated/asm/ftrace.h
  WRAP    arch/um/include/generated/asm/pci.h
  WRAP    arch/um/include/generated/asm/io.h
  WRAP    arch/um/include/generated/asm/param.h
  WRAP    arch/um/include/generated/asm/delay.h
  WRAP    arch/um/include/generated/asm/mutex.h
  WRAP    arch/um/include/generated/asm/current.h
  WRAP    arch/um/include/generated/asm/exec.h
  WRAP    arch/um/include/generated/asm/switch_to.h
  WRAP    arch/um/include/generated/asm/clkdev.h
  WRAP    arch/um/include/generated/asm/trace_clock.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/syscalls/../include/generated/asm/syscalls_32.h
  HOSTCC  scripts/unifdef
  CC      arch/x86/um/user-offsets.s
In file included from /usr/include/stdio.h:28:0,
                 from arch/x86/um/user-offsets.c:1:
/usr/include/features.h:324:26: fatal error: bits/predefs.h: No such file
or directory
compilation terminated.
make[1]: *** [arch/x86/um/user-offsets.s] Error 1
make: *** [arch/x86/um/user-offsets.s] Error 2



> Am Fri, 5 Apr 2013 10:13:24 -0400
> schrieb Peter Butler <PButler@pt.com>:
>
>> OK thanks - will get to that later tonight :-)
>
> Thanks for testing.
> I've fixed some odd bugs currently. The code is in Linus's tree.
> Maybe we need to backport something.
>
> //richard
>


-- 
Peter Butler
Software Engineer, Signaling Systems Group
Performance Technologies Inc.
http://www.pt.com
Tel: 613-287-5403
Fax: 613-287-5377



------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

