Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Hx9-0008AL-0h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 11:22:55 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C7Hx5-0006s5-NP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 11:22:54 -0700
Message-Id: <200409141926.i8EJQm4W003530@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [patch 2/2] add-SIGPROF-get-set_signals 
In-Reply-To: Your message of "Mon, 13 Sep 2004 20:12:29 +0200."
	<200409132012.29994.blaisorblade_spam@yahoo.it> 
References: <20040912182629.3FEC49F37@zion.localdomain>
	<20040913033239.GA13207@ccure.user-mode-linux.org>
	<200409132012.29994.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 14 Sep 2004 15:26:48 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Actually, I had second thoughts about this patch.  I left SIGPROF out of 
[un]block_signals on purpose.  The reason is that you want to be able to
profile all of UML, not just the pieces where signals are enabled.  This is
safe because the profiling code doesn't share any data with the kernel.

A comment to this effect may be warranted, but the signal itself should be
left alone.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
