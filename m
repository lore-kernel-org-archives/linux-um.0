Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM7fA-0008SI-GV	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 10:30:12 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ELPIK-0007nN-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 11:07:42 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Early x86_64 crash
References: <20050929161617.GA30460@ccure.user-mode-linux.org>
In-Reply-To: <20050929161617.GA30460@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_36UPDwjX6Vohysw"
Message-Id: <200509301641.59585.blaisorblade@yahoo.it>
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
Date: Fri, 30 Sep 2005 16:41:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

--Boundary-00=_36UPDwjX6Vohysw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 September 2005 18:16, Jeff Dike wrote:
> If you are running UML/x86_64 and are seeing it crash before starting init,
> I'd like you to do the following:
I assume you've been able to reproduce this crash and see this patch fix it, 
right?

I'm going to take it for -bs3, meanwhile, as soon as you answer on the 
attachment (I'd like it at least to compile).
> 	- make sure that you have CONFIG_FRAME_POINTER disabled
> 	- enable it and see that UML boots
> 	- apply the patch below, disable CONFIG_FRAME_POINTER again, and
> see if UML still boots
> 	- report results back to me

> 				Jeff

> @@ -22,11 +32,14 @@
>
>  	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
Why there's no "%rax" in the register clobber list, here and at the end?
>  	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
> -		"syscall": : "g" (__NR_kill), "g" (SIGUSR1));
> -	/* Two popqs to restore the stack to the state just before entering
> -	 * the handler, one pops the return address, the other pops the frame
> -	 * pointer.
> +		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) :
> +                "%rdi", "%rax", "%rsi");
Here you're correctly informing GCC that your asm uses these regs.
> +	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
> +	 * the signal frame.  So, we use the ucontext pointer, which we know
> +	 * already, to get the signal frame pointer, and add 8 to that.
>  	 */
> -	__asm__("popq %%rax ; popq %%rax ; movq %0, %%rax ; syscall" : : "g"
> -		(__NR_rt_sigreturn));
> +        __asm__("movq %0, %%rsp": :
> +                "g" ((unsigned long) container_of(uc, struct rt_sigframe,
> +						  uc) + 8));
> +	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
>  }
I've attached the addon with additional clobber, and with fixed tabs (i.e. 
hardtabs). Not compiled it (no time to reboot right now).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_36UPDwjX6Vohysw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-early-x86-64-crash-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-early-x86-64-crash-fix"

Index: linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-x86_64/stub_segv.c
+++ linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
@@ -25,20 +25,20 @@ stub_segv_handler(int sig)
 {
 	struct ucontext *uc;
 
-	__asm__("movq %%rdx, %0" : "=g" (uc) :);
+	__asm__("movq %%rdx, %0" : "=g" (uc) : );
         GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
                               &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
+	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid) : "%rax");
 	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
 		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) :
-                "%rdi", "%rax", "%rsi");
+		"%rdi", "%rax", "%rsi");
 	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-        __asm__("movq %0, %%rsp": :
-                "g" ((unsigned long) container_of(uc, struct rt_sigframe,
+	__asm__("movq %0, %%rsp": :
+		"g" ((unsigned long) container_of(uc, struct rt_sigframe,
 						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn) : "%rax");
 }

--Boundary-00=_36UPDwjX6Vohysw--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
