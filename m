Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8Nth-00014U-0j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 11:55:53 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C8Ntf-000574-C2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 11:55:52 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 2/2] add-SIGPROF-get-set_signals
References: <20040912182629.3FEC49F37@zion.localdomain>
	<200409132012.29994.blaisorblade_spam@yahoo.it>
	<200409141926.i8EJQm4W003530@ccure.user-mode-linux.org>
In-Reply-To: <200409141926.i8EJQm4W003530@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409172052.48064.blaisorblade_spam@yahoo.it>
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
Date: Fri, 17 Sep 2004 20:52:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Tuesday 14 September 2004 21:26, Jeff Dike wrote:
> Actually, I had second thoughts about this patch.  I left SIGPROF out of
> [un]block_signals on purpose.  The reason is that you want to be able to
> profile all of UML, not just the pieces where signals are enabled.  This is
> safe because the profiling code doesn't share any data with the kernel.
I agree.
> A comment to this effect may be warranted,
Translate "may" to "should". The Uml code already seems very lacking of 
comments.

> but the signal itself should be 
> left alone.
Ah, ok, but I didn't do that because I saw "well, let's add this, too". I took 
it from change_signals.

In this case, you should remove SIGPROF from change_signals, too.

If you think you may have a possibility to make them different, please take a 
look at the definitions of local_irq_save/restore and 
local_irq_enable/disable, and realize that local_irq_save and 
local_irq_disable should have no hidden difference, i.e. they must treat 
SIGPROF in the same way.

If (I guess not) you have any doubt, I'd recommend asking this on LKML, if you 
feel brave :-)!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
