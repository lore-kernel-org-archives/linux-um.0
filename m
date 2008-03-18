Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jbheb-0001vq-FN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 12:39:21 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user4392)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JbheY-0005eo-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 12:39:20 -0700
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
	<47B5CE40.9000005@club-internet.fr>
	<20080215184650.GA8810@c2.user-mode-linux.org>
	<87y78kx640.fsf_-_@hades.wkstn.nix>
	<20080317193415.GA12234@c2.user-mode-linux.org>
	<87k5k112kf.fsf@hades.wkstn.nix>
	<20080318170019.GA8747@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Tue, 18 Mar 2008 19:39:06 +0000
In-Reply-To: <20080318170019.GA8747@c2.user-mode-linux.org> (Jeff Dike's
	message of "Tue, 18 Mar 2008 13:00:19 -0400")
Message-ID: <87wsnzrfdx.fsf@hades.wkstn.nix>
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

On 18 Mar 2008, Jeff Dike outgrape:

> Below is another patch.
>
> I was hurt and disappointed by your
>> Eeuuuuw. :)
> so I got rid of the 9/10 thing.

Yay! That's much less dependent on the exact nature of whatever the
underlying bug is :) a random 9/10, well, it just makes my skin itch
even if it does work (unless there turned out to be a fundamental reason
why 9/10 was the right value, that is).

> This version keeps track of the time between ticks (as reported by the
> host's gettimeofday) and adjusts its sleeping and reporting ticks
> accordingly.
>
> It's still undersleeping a little - your little test once reported 19
> seconds for a 20 second sleep.  Otherwise, it's reporting sleep times
> that are right on the money.

I think we can live with that. Expecting perfect accuracy, even in a
sleep, is hopeless unless we're niced to realtime priority in any case,
and this looks like it should automatically adapt to varying load on
the host as well, which is really quite neat.

I'll give it an acid test (does ISC dhclient work now?) in a few hours,
when I can afford to drop offline.

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
