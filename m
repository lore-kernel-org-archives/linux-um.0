Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antivano@cisco.com>) id 1XXUjs-0006Vc-Ol
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 12:35:08 +0000
Received: from rcdn-iport-6.cisco.com ([173.37.86.77])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XXUjr-0000lX-Nl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 12:35:08 +0000
From: "Anton Ivanov (antivano)" <antivano@cisco.com>
Date: Fri, 26 Sep 2014 12:35:01 +0000
Message-ID: <54255D73.1030509@cisco.com>
References: <1411732166-653849-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<5425547C.1080002@nod.at>
In-Reply-To: <5425547C.1080002@nod.at>
Content-Language: en-US
Content-ID: <2DCC713F1B656043961679DFA3382354@emea.cisco.com>
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
Subject: Re: [uml-devel] [PATCH] Fix for "occasional userspace process in
	D/Z state" bug
To: Richard Weinberger <richard@nod.at>, "anton.ivanov@kot-begemot.co.uk" <anton.ivanov@kot-begemot.co.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Cc: Daniel Walter <dwalter@google.com>

On 26/09/14 12:56, Richard Weinberger wrote:

[snip]

> +#ifdef CONFIG_X86_32
> +	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2);
> +#else
> +	asm volatile("mfence":::"memory");
> +#endif
> Why not mb()?
> I'm not sure whether this fix is correct.

Looking at the actual defines that would work. I was originally looking 
at asm-generic instead of x86/um/asm/barrier.h and the asm-generic 
barrier() would have been insufficent.

x86/um/asm/barrier.h has literally the same define, so as you noted - 
using mb() will have the same effect.

As far as is this fix correct or not - I do not know myself. I said it 
when submitting it :)

It definitely fixes the problem - both the original (and extremely 
difficult to reproduce) D|Z in the stock UML and the similar (and much 
easier to reproduce) D|Z which you get with all the disk subsystem 
improvement patches.

I will reissue it with mb() shortly.

A.

>
> Thanks,
> //richard

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

