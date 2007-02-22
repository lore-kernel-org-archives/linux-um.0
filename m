Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKI4t-0001pn-0m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:49:59 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKI4q-0001cU-HV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:49:59 -0800
Date: Thu, 22 Feb 2007 12:42:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070222174201.GD3396@ccure.user-mode-linux.org>
References: <200702220054.04938.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702220054.04938.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When opening /tmp/uml.ctl fails, what do we get?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 22, 2007 at 12:54:04AM +0100, Blaisorblade wrote:
> Looking into the code, I saw that:
> 1) daemon_user_init is confusing because it saved any error into pri->fd, 
> instead of returning it to the caller. 

Yup.

> Also, it would make sense to move this into daemon_open.

The current behavior is on purpose.  The thinking is that device
initialization is equivalent to plugging a box into a switch.  The
device isn't up (and the box might in fact be turned off).  Bringing
the interface up comes later, as a separate step.

You may be right, and we can talk about it, but the current code is no
accident.

> 2) connect_to_switch uses the same errno twice - it shouldn't, and we're 
> hitting this. um_interrupt is called with fd => 0 because errno is cleared 
> after printk (verified under debugging, I did not trace it fully to where 
> it's changing but it's sufficient for a patch anyway).

We've seen this before, and I thought I made a pass over all of UML
and fixed everything.  Sigh.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
