Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jxer4-0002Lf-RG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 May 2008 02:06:59 -0700
Received: from an-out-0708.google.com ([209.85.132.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jxer2-00017V-IG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 May 2008 02:06:57 -0700
Received: by an-out-0708.google.com with SMTP id b21so363188ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 May 2008 02:06:56 -0700 (PDT)
Message-ID: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
Date: Sun, 18 May 2008 17:06:55 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] =?windows-1252?q?=91struct_thread=5Fstruct=92_has_no_?=
	=?windows-1252?q?member_named_=91mode=92?=
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
To: user-mode-linux-devel@lists.sourceforge.net

I downloaded 2.6.24.2.tar.bz2 and make:

/mnt/hd0/download/linux-2.6.24.2>make ARCH=um O=obj
make[1]: Nothing to be done for `/mnt/hd0/download/linux-2.6.24.2/obj'.
/mnt/hd0/download/linux-2.6.24.2>make linux ARCH=um O=obj
make[1]: Nothing to be done for `/mnt/hd0/download/linux-2.6.24.2/obj'.
  SYMLINK arch/um/include/sysdep
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  Using /mnt/hd0/download/linux-2.6.24.2 as source for kernel
  GEN     /mnt/hd0/download/linux-2.6.24.2/obj/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    /mnt/hd0/download/linux-2.6.24.2/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/um/kernel/smp.o
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c: In function 'idle_proc':
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:79: error:
'struct thread_struct' has no member named 'mode'
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c: In function
'idle_thread':
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:106: error:
'cpu_tasks' undeclared (first use in this function)
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:106: error:
(Each undeclared identifier is reported only once
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:106: error: for
each function it appears in.)
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:107: error:
unknown field 'pid' specified in initializer
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:107: error:
'struct thread_struct' has no member named 'mode'
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:107: warning:
excess elements in struct initializer
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:107: warning:
(near initialization for '(anonymous)')
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:108: error:
unknown field 'task' specified in initializer
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:108: warning:
excess elements in struct initializer
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:108: warning:
(near initialization for '(anonymous)')
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c: In function
'smp_prepare_cpus':
/mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:133: error:
'struct thread_struct' has no member named 'mode'
make[2]: *** [arch/um/kernel/smp.o] Error 1
make[1]: *** [arch/um/kernel] Error 2
make: *** [sub-make] Error 2

What is happening, appreciate very much for any help rendered :-).
-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
