Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcAn1-0005gj-Ue for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 16:04:39 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcAmx-0003p2-7j
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 16:04:40 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
Message-ID: <20051116005710.GA11520@ccure.user-mode-linux.org>
References: <20051114215517.GA9579@ccure.user-mode-linux.org>
	<20051115220903.73648.qmail@web25208.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115220903.73648.qmail@web25208.mail.ukl.yahoo.com>
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
Date: Tue, 15 Nov 2005 19:57:10 -0500
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 15, 2005 at 11:09:03PM +0100, Paolo Giarrusso wrote:
> I've come to a (possible) conclusion - probably we could try to adapt
> and reuse the batching syscall stub to do everything. With the
> original single-syscall stub it didn't make sense, with this one it
> could do. 

What would that look like?  An array of numbers representing register
values to be given to the batch syscall stub?  Or the syscall_stub* macros
would fill in an array?

> Or anyway, it's possibly becoming harder to write all this in C with
> assembly inserts rather than directly in assembly. It also does not
> work well on some strange compilers (aka Hardened GCC, as reported by
> Antoine Martin).

I'm wondering about this as well.  I'm unsure whether we are mopping up the
last few problems, or whether we will just be seeing misassembly after
misassembly.

At least this patch is a clear bug fix.

> > -/*	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
> > -	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
> > -		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1)); */
> 
> Where does this commented getpid + kill comes from? It seems to come
> from rubbish in some patch.

This patch was at the end of my series - the current version doesn't have
this.

> The idea would be nice, but I am reluctant in trusting GCC to leave
> %esp unaltered; also, without volatile, GCC feels probably allowed to
> move this instruction anywhere in the code.

OK, I changed it back.

> Actually, I start feeling this could be moved to assembly.

Maybe.  I prefer C as long as that is viable, though.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
