Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1P5Qm9-0005uM-IY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2010 22:23:21 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5Qm7-0001OK-Pr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2010 22:23:21 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 Oct 2010 00:23:10 +0200
References: <1286832575-21474-1-git-send-email-richard@nod.at>
	<20101011151447.1a022f25.akpm@linux-foundation.org>
In-Reply-To: <20101011151447.1a022f25.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <201010120023.10861.richard@nod.at>
Subject: Re: [uml-devel] [PATCH 1/1] um: Get rid of __do_IRQ()
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, peterz@infradead.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, tj@kernel.org, tglx@linutronix.de, mingo@elte.hu

Am Dienstag 12 Oktober 2010, 00:14:47 schrieb Andrew Morton:
> What's the plan here?  Are all architectures supposed to me migrating
> away from __do_IRQ() and over to generic_handle_irq(), or what?

Yes.

Documentation/feature-removal-schedule.txt:

What: __do_IRQ all in one fits nothing interrupt handler
When: 2.6.32
Why:  __do_IRQ was kept for easy migration to the type flow handlers.
  More than two years of migration time is enough.
Who:  Thomas Gleixner <tglx@linutronix.de>

Thanks,
//richard

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

