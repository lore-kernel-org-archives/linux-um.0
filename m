Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt2TM-0007pZ-3N	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 05:05:48 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt2Sr-0000RO-Uj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 05:05:48 -0700
Message-ID: <42D654F7.2080608@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<42D504D8.1010606@fujitsu-siemens.com> <200507131647.53822.rob@landley.net>
	<42D6459B.6080702@fujitsu-siemens.com>
In-Reply-To: <42D6459B.6080702@fujitsu-siemens.com>
Content-Type: multipart/mixed;
 boundary="------------060406050406040706070101"
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
Date: Thu, 14 Jul 2005 14:05:11 +0200
To: Rob Landley <rob@landley.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

This is a multi-part message in MIME format.
--------------060406050406040706070101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bodo Stroesser wrote:
> stub_segv_handler misses the "push ebp" at the beginning. As you
> do the normally corresponding "pop eax" explicitly, I think stack
> pointer is wrong on call of sigreturn.
> 
> I have no idea, what makes happen this. Maybe it depends on compiler
> version?
> 

I hope, the attached patch fixes the problem. The patch is tested in
my 2.6.12-rc4 + skas0, where I didn't see the problem. It still works
fine for me.

Rob, could you please test whether the patch fixes the problem for you?

	Bodo

--------------060406050406040706070101
Content-Type: text/x-diff;
 name="fix-stub_segv-stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-stub_segv-stack.patch"

# 
# From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
# 
# It's wrong to pop a fixed number of words from stack before
# calling sigreturn, as the number depends on what code is generated
# by the compiler for the start of stub_segv_handler().
# What we need is esp containing the address of sigcontext. So we
# explicitly load that pointer into esp.
# 
# Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Index: linux-2.6.12-rc4/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/um/sys-i386/stub_segv.c	2005-07-14 13:15:53.364847980 +0200
+++ linux-2.6.12-rc4/arch/um/sys-i386/stub_segv.c	2005-07-14 13:36:02.980002269 +0200
@@ -22,10 +22,10 @@ stub_segv_handler(int sig)
 	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
 	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
 		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Pop the frame pointer and return address since we need to leave
+	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
-	__asm__("popl %%eax ; popl %%eax ; popl %%eax ; movl %0, %%eax ; "
-		"int $0x80" : : "g" (__NR_sigreturn));
+	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
+		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
 }

--------------060406050406040706070101--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
