Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSrjD-0004oa-JD	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 May 2005 00:21:59 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DSrjD-0002BH-2n
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 May 2005 00:21:59 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050503002126.1f40f5bf.akpm@osdl.org>
In-Reply-To: <20050501190851.5FD5B45EBB@zion>
References: <20050501190851.5FD5B45EBB@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] x86_64: make string func definition work
	as intended
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
Date: Tue, 3 May 2005 00:21:26 -0700
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, ak@suse.de

blaisorblade@yahoo.it wrote:
>
> In include/asm-x86_64/string.h there are such comments:
> 
>  /* Use C out of line version for memcmp */ 
>  #define memcmp __builtin_memcmp
>  int memcmp(const void * cs,const void * ct,size_t count);
> 
>  This would mean that if the compiler does not decide to use __builtin_memcmp,
>  it emits a call to memcmp to be satisfied by the C out-of-line version in
>  lib/string.c. What happens is that after preprocessing, in lib/string.i you
>  may find the definition of "__builtin_strcmp".
> 
>  Actually, by accident, in the object you will find the definition of
>  strcmp and such (maybe a trick intended to redirect calls to __builtin_memcmp
>  to the default memcmp when the definition is not expanded); however, this
>  particular case is not a documented feature as far as I can see.
> 
>  Also, the EXPORT_SYMBOL does not work, so it's duplicated in the arch.

This breaks the x86 build.  I guess the below is right.

You wanna check other architectures please?


diff -puN arch/i386/kernel/i386_ksyms.c~x86_64-make-string-func-definition-work-as-intended-fix arch/i386/kernel/i386_ksyms.c
--- 25/arch/i386/kernel/i386_ksyms.c~x86_64-make-string-func-definition-work-as-intended-fix	2005-05-03 00:16:36.000000000 -0700
+++ 25-akpm/arch/i386/kernel/i386_ksyms.c	2005-05-03 00:16:44.000000000 -0700
@@ -169,10 +169,6 @@ EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL_GPL(set_nmi_callback);
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
-#undef memcmp
-extern int memcmp(const void *,const void *,__kernel_size_t);
-EXPORT_SYMBOL(memcmp);
-
 EXPORT_SYMBOL(register_die_notifier);
 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(_atomic_dec_and_lock);
_



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
