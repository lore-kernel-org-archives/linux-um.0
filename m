Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nix@esperi.org.uk>) id 1Lnu4b-0005b8-RQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 12:25:09 +0000
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]
	helo=mail.esperi.org.uk) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Lnu4W-0001MQ-Lq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 12:25:09 +0000
References: <a37615150903261150x3642d954y296b6e8c26e53fe8@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
Date: Sun, 29 Mar 2009 13:08:49 +0100
In-Reply-To: <a37615150903261150x3642d954y296b6e8c26e53fe8@mail.gmail.com>
	(Yehuda Sadeh Weinraub's message of "Thu,
	26 Mar 2009 11:50:34 -0700")
Message-ID: <87hc1cbkfi.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] Networking issues with 2.6.29
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
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 26 Mar 2009, Yehuda Sadeh Weinraub spake thusly:

> Network doesn't seem to work for me in 2.6.29, although it was working
> in 2.6.28. System behavior seemed really strange, as it sometimes did
> work when I was using the same uml machine, when using a different
> user. Bisecting the kernel tree, revels a seemingly unrelated commit
> that when reverted it fixes the problem:

I doubt it. This is a known race, particularly easy to reproduce on UP,
fixed by <http://patchwork.kernel.org/patch/14465/>, which causes
networking to go away at seemingly random moments. I had it everywhere
within ten minutes of upgrading...

> commit 470c66239ef0336429b35345f3f615d47341e13b
> Author: David Brownell <dbrownell@users.sourceforge.net>
> Date:   Mon Dec 1 14:31:37 2008 -0800
>
>     genirq: warn when IRQF_DISABLED may be ignored

This patch just adds an (annoying and useless to users) warning that's
printed at interface bringup time. If it makes the problem go away I'll
eat my hat.

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

