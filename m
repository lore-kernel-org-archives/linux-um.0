Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUFqz-0006J4-MD	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 20:19:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUFqy-0000cb-4X	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 20:19:45 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
Message-ID: <20050507031500.GE14445@ccure.user-mode-linux.org>
References: <s2788296.000@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2788296.000@ORANGE.OUS.EDU>
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
Date: Fri, 6 May 2005 23:15:00 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, May 04, 2005 at 08:06:22AM -0700, Anthony Brock wrote:
> Okay, I've now recompiled the host kernel to include debugging information. I now get the following:
> 
> myserver:~# 
> Program received signal SIGSEGV, Segmentation fault.
> chan_interrupt (chans=0x4013a3cc, task=0x4013a3fc, tty=0xbc1c000, irq=2) at arch/um/drivers/chan_kern.c:535

Can you see if you can make it happen with current -mm or current 2.6.12-rc?

Not that I think it's fixed there, but those are the trees I have handy, and
the line numbers will make a lot more sense to me then.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
