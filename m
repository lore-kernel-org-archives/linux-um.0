Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJwVk-0002BZ-MA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 09:06:56 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJwVj-0005K2-QY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 09:06:56 -0700
Message-ID: <41753C88.1080808@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <8B6FF516CBA0194AB0996705076B02520F7C48@ABGEX01E.abg.fsc.net>
	<200410182116.i9ILG3UA013132@ccure.user-mode-linux.org>
	<41743383.6030407@fujitsu-siemens.com>
	<200410182347.17797.blaisorblade_personal@yahoo.it>
In-Reply-To: <200410182347.17797.blaisorblade_personal@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Security patches 1- 3
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
Date: Tue, 19 Oct 2004 18:10:48 +0200
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Paolo Giarrusso wrote:
> 
> Ok, I guess I have understood you. I could insert it, but first I would like 
> to have it tested. However, for now -v6 is released with the other change you 
> posted.
> 
Today I installed a 2.6.7-skas3.v6 host. And I adapted and applied also the patch
from bitkeeper. For me, this combination works fine. So here is the slightly
modified patch.

Bodo

----

# Modified to apply to Linux-2.6.7 + host-skas3-2.6.7-v6.patch
#
#
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/08 07:49:36-07:00 roland@redhat.com
#   [PATCH] i386 syscall tracing of bogus system calls
#
#   In 2.4, strace will show you all bogus system calls a process tries.  In
#   2.6, it only shows you stubs < __NR_syscalls, and there is no tracing stop
#   for large bogus system call numbers.  I can't see why this was changed, so
#   I am assuming it was accidental.
#
#   This patch restores the expected behavior that syscall tracing shows every
#   bogus syscall attempt.
#
#   Signed-off-by: Roland McGrath <roland@redhat.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#
# arch/i386/kernel/entry.S
#   2004/09/08 07:49:29-07:00 roland@redhat.com +4 -4
#   i386 syscall tracing of bogus system calls
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	2004-10-19 02:40:35 -07:00
+++ b/arch/i386/kernel/entry.S	2004-10-19 02:40:35 -07:00
@@ -255,11 +255,11 @@
  	pushl %eax
  	SAVE_ALL
  	GET_THREAD_INFO(%ebp)
-	cmpl $(nr_syscalls), %eax
-	jae syscall_badsys

  	testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
  	jnz syscall_trace_entry
+	cmpl $(nr_syscalls), %eax
+	jae syscall_badsys
  	call *sys_call_table(,%eax,4)
  	movl %eax,EAX(%esp)
  	cli
@@ -278,11 +278,11 @@
  	pushl %eax			# save orig_eax
  	SAVE_ALL
  	GET_THREAD_INFO(%ebp)
-	cmpl $(nr_syscalls), %eax
-	jae syscall_badsys
  					# system call tracing in operation / emulation
  	testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
  	jnz syscall_trace_entry
+	cmpl $(nr_syscalls), %eax
+	jae syscall_badsys
  syscall_call:
  	call *sys_call_table(,%eax,4)
  	movl %eax,EAX(%esp)		# store the return value


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
