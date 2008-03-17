Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbMZS-0000qQ-Ho for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 14:08:38 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user43400)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JbMZP-0006ws-Rx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 14:08:38 -0700
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
	<47B5CE40.9000005@club-internet.fr>
	<20080215184650.GA8810@c2.user-mode-linux.org>
	<87y78kx640.fsf_-_@hades.wkstn.nix>
	<20080317193415.GA12234@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Mon, 17 Mar 2008 21:08:16 +0000
In-Reply-To: <20080317193415.GA12234@c2.user-mode-linux.org> (Jeff Dike's
	message of "Mon, 17 Mar 2008 15:34:15 -0400")
Message-ID: <87k5k112kf.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] [2.6.24.x] UML select()/poll() oversleeping
	reproducibly
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
Cc: Thomas Gleixner <tglx@timesys.com>, linux-kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On 17 Mar 2008, Jeff Dike verbalised:

> Below is the same patch with another kluge, which cuts down the
> requested sleep by 10% in hopes of getting the actual sleep closer to
> what's wanted.

Eeuuuuw. :)

> This is unusable in anything resembling mainline, but I'd like to see
> how your various systems react to it.  I'm getting very close to the
> sleeps I asked for (with slight undersleeping, which is a bug).

OK.

Tests on host with clocksource pit:

bash-3.2# bin/select-sleep 5
Slept for 5 seconds.
bash-3.2# bin/select-sleep 10
Slept for 11 seconds.
bash-3.2# bin/select-sleep 30
Slept for 31 seconds.
bash-3.2# bin/select-sleep 60
Slept for 61 seconds.

... so much better than the 4x error without this patch.

Tests on host with clocksource tsc:

bash-3.2# bin/select-sleep 5
Slept for 5 seconds.
bash-3.2# bin/select-sleep 10
Slept for 10 seconds.
bash-3.2# bin/select-sleep 30
Slept for 30 seconds.
bash-3.2# bin/select-sleep 60
Slept for 61 seconds.

Distinctly better than without this patch.

(Am I the only person who finds it strange that (some) clocksource
hackers are arguing about accuracy problems in the ppm range while we're
glad to get an error of `only' single seconds per minute out of it? 
Maybe next year we can invent the `pendulum' clocksource :) )

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
