Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Jzd-0001Mc-HR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 11:15:21 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user37973)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4Jzb-0000EV-C8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 11:15:21 -0700
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603123211.e129c222.akpm@linux-foundation.org>
	<200806031543.56864.dhazelton@enter.net>
	<878wxmfg99.fsf@hades.wkstn.nix>
	<20080603130709.fcf6a751.akpm@linux-foundation.org>
	<20080603210048.GA12182@c2.user-mode-linux.org>
	<4846A75E.40305@goop.org>
	<20080604193715.GA11943@c2.user-mode-linux.org>
	<4846F577.10603@goop.org>
	<20080605153008.GC7311@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Thu, 05 Jun 2008 19:14:30 +0100
In-Reply-To: <20080605153008.GC7311@c2.user-mode-linux.org> (Jeff Dike's
	message of "Thu, 5 Jun 2008 11:30:08 -0400")
Message-ID: <87k5h392bd.fsf@hades.wkstn.nix>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dhazelton@enter.net

On 5 Jun 2008, Jeff Dike verbalised:
> Aha, I was looking at timer_* and not getting reasonable-looking
> results.  The one questionable aspect of this is that I need to pull
> in a new library (librt) and I wonder how many people don't have it
> installed...

It comes with glibc, and even ls uses it (for clock_gettime(), to
determine what format to use for date display).

I'd say using it is about as safe as can be.

> Anyway, the patch below seems to make the guest behave reasonably in
> the face of the host time doing funky things...
>
> Give it a spin and let me know how it does.  If there aren't any
> problems, I'll get it into mainline.

Rebuilding for a test now.

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
