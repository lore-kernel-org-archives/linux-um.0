Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9J8-00018V-Jl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:10 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9J4-0007ZA-7z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/3] UML - Change sigjmp_buf to jmp_buf
References: <200604102337.k3ANb659006843@ccure.user-mode-linux.org>
In-Reply-To: <200604102337.k3ANb659006843@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604191151.53281.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:51:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Tuesday 11 April 2006 01:37, Jeff Dike wrote:
> Clean up the jmpbuf code.  Since softints, we no longer use sig_setjmp, so
> the UML_SIGSETJMP wrapper now has a misleading name.  Also, I forgot to
> change the buffers from sigjmp_buf to jmp_buf.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Can I request (additionally) a look at remaining calls to {sig,}setjmp() and 
sigprocmask(), like the below one and the one in (IIRC) thread_wait()?

I think that probably some of them are valid because signal handlers modify 
the signal mask, so we may still need to play with it, but:

* I don't remember (I may be wrong) mention of this in the changelog of the 
softints patch,

* you had IIRC doubts on the current code (when I noted thread_wait())

* an analysis of what is correct should end up in a comment somewhere 
describing the results.

I won't have the time to work on this soon, at least not this week, and I 
didn't write the code.

When I'll get time, I'll work on merging RemapFilePages in -mm (I'm reasonably 
near to resend it, but I can't until I've made sure all changelogs are 
up-to-date and clear enough).

> Index: linux-2.6.16-mm/arch/um/os-Linux/util.c
> ===================================================================

>  int setjmp_wrapper(void (*proc)(void *, void *), ...)
>  {
>  	va_list args;
> -	sigjmp_buf buf;
> +	jmp_buf buf;
>  	int n;
>
>  	n = sigsetjmp(buf, 1);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
