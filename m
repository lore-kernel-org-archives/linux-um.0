Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3zF3-0005GQ-2K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 13:05:53 -0700
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3zF1-0006cW-Mp
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 13:05:52 -0700
Message-ID: <4846F577.10603@goop.org>
Date: Wed, 04 Jun 2008 21:05:11 +0100
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603123211.e129c222.akpm@linux-foundation.org>
	<200806031543.56864.dhazelton@enter.net>
	<878wxmfg99.fsf@hades.wkstn.nix>
	<20080603130709.fcf6a751.akpm@linux-foundation.org>
	<20080603210048.GA12182@c2.user-mode-linux.org>
	<4846A75E.40305@goop.org>
	<20080604193715.GA11943@c2.user-mode-linux.org>
In-Reply-To: <20080604193715.GA11943@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Nix <nix@esperi.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dhazelton@enter.net

Jeff Dike wrote:
> On Wed, Jun 04, 2008 at 03:31:58PM +0100, Jeremy Fitzhardinge wrote:
>   
>> Shouldn't UML use a monotonic host clock for guest timekeeping?
>>     
>
> Indeed, Eric pointed out the posix timers, which I had forgotten
> about.  On the face of it, a monotonic timer should do the trick, but
> it's not obvious how to get it to behave like a monotonic
> gettimeofday...

You can either read the monotonic clock directly, or use it as a time 
source for a monotonic timer.  clock_gettime(CLOCK_MONOTONIC, &ts) will 
return the time in ns, and you can just feed that directly into the 
guest as a clocksource.

    J

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
