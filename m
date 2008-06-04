Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3lIi-0007bw-FP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 22:12:44 -0700
Received: from keil-draco.com ([216.193.185.50] helo=mail.keil-draco.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3lIh-0006As-3N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 22:12:44 -0700
From: Daniel Hazelton <dhazelton@enter.net>
Date: Wed, 4 Jun 2008 01:12:34 -0400
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603210048.GA12182@c2.user-mode-linux.org>
	<m1zlq2vuh2.fsf@frodo.ebiederm.org>
In-Reply-To: <m1zlq2vuh2.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806040112.35245.dhazelton@enter.net>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Nix <nix@esperi.org.uk>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tuesday 03 June 2008 09:50:49 pm Eric W. Biederman wrote:
> Jeff Dike <jdike@addtoit.com> writes:
> > On Tue, Jun 03, 2008 at 01:07:09PM -0700, Andrew Morton wrote:
> >> So if I change the host's time by an hour, the time will not advance at
> >> all on the guest for the next hour? Sounds suboptimal :)
> >
> > It is, but if the host is whacked, the guest just has to do the best that
> > it can...
>
> Could using a CLOCK_MONOTONIC time source fix this?  Those timers do not
> change when we change the time on the host.
>
> Eric

I'm not all that familiar with the specifics of the code - my original 
statements about possible causes were barely more than wild guesses - but 
this does sound like it would work.

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
