Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paul.Gortmaker@windriver.com>) id 1W2Ofy-0007Sg-3i
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 17:18:18 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2Ofw-0002z8-0r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 17:18:18 +0000
Date: Sun, 12 Jan 2014 12:18:01 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <20140112171801.GA10322@windriver.com>
References: <20140112120305.GA13076@gmail.com>
	<1389538341-31383-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389538341-31383-1-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um, x86: Fix vDSO build
To: Richard Weinberger <richard@nod.at>
Cc: linux-tip-commits@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com

[[PATCH] um, x86: Fix vDSO build] On 12/01/2014 (Sun 15:52) Richard Weinberger wrote:

> Commit "x86: Delete non-required instances of include <linux/init.h>"
> broke the UML build.
> 
> arch/x86/um/vdso/vdso.S: Assembler messages:
> arch/x86/um/vdso/vdso.S:2: Error: no such instruction: `__initdata'
> arch/x86/um/vdso/vdso.S:9: Error: no such instruction: `__finit'
> 
> UML's vDSO needs linux/init.h.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thanks Richard & Ingo.  I did these cleanups last fall but never got
around to submitting them until now;  I think the false positives for
removal crept in when I manually started the process, before realizing
the scale of it needed automatic selection/application and verification.

And without me doing uml testing, I never got a chance to see the
breakage and undo it.  I'll definitely add uml to my regular testing.

I see hpa has already put this on x86/cleanups, but for the record:

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks again and sorry for the inconvenience.
P.
--

> ---
>  arch/x86/um/vdso/vdso.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
> index 4b4bd4c..1cb468a 100644
> --- a/arch/x86/um/vdso/vdso.S
> +++ b/arch/x86/um/vdso/vdso.S
> @@ -1,3 +1,4 @@
> +#include <linux/init.h>
>  
>  __INITDATA
>  
> -- 
> 1.8.1.4
> 

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today.
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

