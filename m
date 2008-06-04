Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3iAC-00051q-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 18:51:44 -0700
Received: from out01.mta.xmission.com ([166.70.13.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3iAB-0006HO-M0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 18:51:44 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603123211.e129c222.akpm@linux-foundation.org>
	<200806031543.56864.dhazelton@enter.net>
	<878wxmfg99.fsf@hades.wkstn.nix>
	<20080603130709.fcf6a751.akpm@linux-foundation.org>
	<20080603210048.GA12182@c2.user-mode-linux.org>
Date: Tue, 03 Jun 2008 18:50:49 -0700
In-Reply-To: <20080603210048.GA12182@c2.user-mode-linux.org> (Jeff Dike's
	message of "Tue, 3 Jun 2008 17:00:48 -0400")
Message-ID: <m1zlq2vuh2.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
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

Jeff Dike <jdike@addtoit.com> writes:

> On Tue, Jun 03, 2008 at 01:07:09PM -0700, Andrew Morton wrote:
>> So if I change the host's time by an hour, the time will not advance at all
>> on the guest for the next hour? Sounds suboptimal :)
>
> It is, but if the host is whacked, the guest just has to do the best that
> it can...

Could using a CLOCK_MONOTONIC time source fix this?  Those timers do not
change when we change the time on the host.

Eric

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
