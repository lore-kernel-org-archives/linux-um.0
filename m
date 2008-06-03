Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3cQn-00022O-1o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:44:29 -0700
Received: from keil-draco.com ([216.193.185.50] helo=mail.keil-draco.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3cQj-0005st-My
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:44:27 -0700
From: Daniel Hazelton <dhazelton@enter.net>
Date: Tue, 3 Jun 2008 15:43:56 -0400
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603123211.e129c222.akpm@linux-foundation.org>
In-Reply-To: <20080603123211.e129c222.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806031543.56864.dhazelton@enter.net>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Deal with host time going backwards
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nix@esperi.org.uk, Jeff Dike <jdike@addtoit.com>, akpm@linuxfoundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 03 June 2008 03:32:11 pm Andrew Morton wrote:
> On Tue, 3 Jun 2008 15:02:35 -0400
>
> Jeff Dike <jdike@addtoit.com> wrote:
> > Protection against the host's time going backwards - keep track of the
> > time at the last tick and if it's greater than the current time, keep
> > time stopped until the host catches up.
>
> Strange.  What would cause the host's time (or at least UML's perception
> of it) to go backwards?

A wild guess would be that the UML process is running "fast" at some point and 
its expectation of the host's time is skewed forward because of that.

Another possibility is that the hosts clock got reset between the times UML 
has checked it and the correction was a negative one.

DRH

-- 
Dialup is like pissing through a pipette. Slow and excruciatingly painful.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
