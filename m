Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1Lx1uN-0007cc-M8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Apr 2009 16:36:19 +0000
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Lx1uL-0006k3-S8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Apr 2009 16:36:19 +0000
Date: Thu, 23 Apr 2009 12:06:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090423160659.GD9820@c2.user-mode-linux.org>
References: <20090418154021.GA14617@ivl.dyndns.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090418154021.GA14617@ivl.dyndns.org>
Subject: Re: [uml-devel] [Patch] Save FPU registers between task switches
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
To: Ingo van Lil <inguin@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 18, 2009 at 05:40:21PM +0200, Ingo van Lil wrote:
> some time ago Jeff prepared a patch [1] for UML to stop saving the
> process FP state between task switches. The assumption was that since
> with SKAS0 every guest process runs inside a host process context the
> host OS will take care of keeping the proper FP state. Unfortunately
> this is not true for multi-threaded applications, where all guest
> threads share a single host process context yet all may use the FPU on
> their own. Although I haven't verified it I suspect things to be even
> worse in SKAS3 mode where all guest processes run inside a single host
> process.

This seems plausible.  Does reverting the patch fix any process crashes?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

