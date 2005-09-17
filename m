Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGifB-0006QK-3M	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 12:47:53 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGif9-0006I3-UG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 12:47:53 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
Message-ID: <20050917185237.GA6726@ccure.user-mode-linux.org>
References: <1126653933.3769.45.camel@localhost>
	<200509162124.42522.blaisorblade@yahoo.it>
	<1126901562.17715.9.camel@localhost>
	<200509171741.30694.blaisorblade@yahoo.it>
	<1126980920.1169.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126980920.1169.13.camel@localhost>
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
Date: Sat, 17 Sep 2005 14:52:37 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Sep 17, 2005 at 07:15:19PM +0100, Antoine Martin wrote:
> Here is the repeated message:
> [42977981.360000] Badness in local_bh_enable at kernel/softirq.c:140
> [42977981.360000] a037f6c0:  [<a001c4de>] dump_stack+0x1e/0x20
> [42977981.360000] a037f6e0:  [<a0053fcc>] local_bh_enable+0x6c/0x90
> [42977981.360000] a037f710:  [<a0230caa>] __dev_remove_pack+0x7a/0xa0
> [42977981.360000] a037f720:  [<a0293b93>] packet_notifier+0xd3/0x130
> [42977981.360000] a037f750:  [<a005df9e>] notifier_call_chain+0x1e/0x40
> [42977981.360000] a037f780:  [<a0231689>] dev_close+0x89/0xa0
> [42977981.360000] a037f7b0:  [<a0039058>] uml_net_interrupt+0x68/0x70

Looks like dev_close shouldn't be called from an interrupt, since it enables
interrupts.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
