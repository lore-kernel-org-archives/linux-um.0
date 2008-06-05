Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4NEI-0005OL-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:42:42 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user30563)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4NEG-0001xZ-N3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:42:42 -0700
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
	<20080605194732.GB13348@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Thu, 05 Jun 2008 22:41:55 +0100
In-Reply-To: <20080605194732.GB13348@c2.user-mode-linux.org> (Jeff Dike's
	message of "Thu, 5 Jun 2008 15:47:32 -0400")
Message-ID: <87bq2f8spo.fsf@hades.wkstn.nix>
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

On 5 Jun 2008, Jeff Dike uttered the following:

> On Thu, Jun 05, 2008 at 07:14:30PM +0100, Nix wrote:
>> It comes with glibc, and even ls uses it (for clock_gettime(), to
>> determine what format to use for date display).
>> 
>> I'd say using it is about as safe as can be.
>
> Without adding -lrt to the link line here (F7), I get

Yes, you'll definitely *need* -lrt for clock_*().

> arch/um/os-Linux/built-in.o: In function `nsecs':
> /home/jdike/linux/2.6/linux-2.6.22/arch/um/os-Linux/time.c:84: undefined reference to `clock_gettime'
> collect2: ld returned 1 exit status
>
> A little odd for a system call...

I think it's in there because it's part of the POSIX realtime
extensions, so you should have to, as it were, assent to using something
that's not as portable as just using libc. It makes more sense than
libm, anyway.

(It's completely moot for UML of course :) )

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
