Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvF09-0002Sm-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 07:57:17 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FvF05-0002xI-VL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 07:57:17 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 27 Jun 2006 16:56:13 +0200
References: <20060626220234.GG4223@us.ibm.com>
In-Reply-To: <20060626220234.GG4223@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606271656.13712.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, jdike@addtoit.com

On Tuesday 27 June 2006 00:02, Nishanth Aravamudan wrote:
> Hi Jeff,
>
> I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and decided
> to try out UML today. I found that UML wasn't quite aware of biarch
> compilers (which Ubuntu i386 ships). A fix similar to what was done for
> x86_64 should probably be committed (see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).

Ok, it seemed strange but I understand the stuff... that's very interesting as 
this is the setup I'd wished to have since ages. I'll switch to it ASAP...

> Without the FLAGS changes, the build will fail at a number of places and
> without the LINK change, the final link will fail.
>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

The first hunk (#undef i386) should be unnecessary given you specify -m64 (add 
it to CPPFLAGS too). Also it can/could be problematic for i386 kernels.
However, if UML builds and runs on already supported configurations, the patch 
is almost ok - but the original comment must be added for the #undef:
/* in case the preprocessor is a 32bit one */

> diff -urpN 2.6.17/arch/um/kernel/vmlinux.lds.S
> 2.6.17-dev/arch/um/kernel/vmlinux.lds.S ---
> 2.6.17/arch/um/kernel/vmlinux.lds.S	2006-06-17 18:49:35.000000000 -0700 +++
> 2.6.17-dev/arch/um/kernel/vmlinux.lds.S	2006-06-26 14:55:45.000000000 -0700
> @@ -1,4 +1,5 @@
>  #include <linux/config.h>
> +#undef i386
>  #ifdef CONFIG_LD_SCRIPT_STATIC
>  #include "uml.lds.S"
>  #else
> diff -urpN 2.6.17/arch/um/Makefile-x86_64
> 2.6.17-dev/arch/um/Makefile-x86_64 ---
> 2.6.17/arch/um/Makefile-x86_64	2006-06-17 18:49:35.000000000 -0700 +++
> 2.6.17-dev/arch/um/Makefile-x86_64	2006-06-26 14:49:01.000000000 -0700 @@
> -6,9 +6,11 @@ START := 0x60000000
>
>  #We #undef __x86_64__ for kernelspace, not for userspace where
>  #it's needed for headers to work!
> -CFLAGS += -U__$(SUBARCH)__ -fno-builtin
> -USER_CFLAGS += -fno-builtin
> +CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
> +USER_CFLAGS += -fno-builtin -m64
>  CHECKFLAGS  += -m64
> +AFLAGS += -m64
> +LDFLAGS += -m elf_x86_64
>
>  ELF_ARCH := i386:x86-64
>  ELF_FORMAT := elf64-x86-64
> @@ -16,3 +18,4 @@ ELF_FORMAT := elf64-x86-64
>  # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an
> example.
>
>  LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
> +LINK-y += -m64

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
