Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4LRZ-0002MV-Mm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 12:48:17 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4LRX-0003Dv-Qb
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 12:48:17 -0700
Date: Thu, 5 Jun 2008 15:47:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080605194732.GB13348@c2.user-mode-linux.org>
References: <20080603123211.e129c222.akpm@linux-foundation.org>
	<200806031543.56864.dhazelton@enter.net>
	<878wxmfg99.fsf@hades.wkstn.nix>
	<20080603130709.fcf6a751.akpm@linux-foundation.org>
	<20080603210048.GA12182@c2.user-mode-linux.org>
	<4846A75E.40305@goop.org>
	<20080604193715.GA11943@c2.user-mode-linux.org>
	<4846F577.10603@goop.org>
	<20080605153008.GC7311@c2.user-mode-linux.org>
	<87k5h392bd.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k5h392bd.fsf@hades.wkstn.nix>
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
To: Nix <nix@esperi.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dhazelton@enter.net

On Thu, Jun 05, 2008 at 07:14:30PM +0100, Nix wrote:
> It comes with glibc, and even ls uses it (for clock_gettime(), to
> determine what format to use for date display).
> 
> I'd say using it is about as safe as can be.

Without adding -lrt to the link line here (F7), I get

arch/um/os-Linux/built-in.o: In function `nsecs':
/home/jdike/linux/2.6/linux-2.6.22/arch/um/os-Linux/time.c:84: undefined reference to `clock_gettime'
collect2: ld returned 1 exit status

A little odd for a system call...

> Does this really only apply on top of 2.6.22? Which of the bewildering
> blizzard of time-fixup patches we've been exchanging do I need? :)

I have it on top of 2.6.26-rc2-mm1, plus all the other patches I've
sent to Andrew.  The patch which started this discussion is the one
you really need though, since this backs it out.

    	   		Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
