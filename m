Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jc6YH-0007Kf-Mo for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2008 15:14:29 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user52366)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jc6YF-0004Yt-1r
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2008 15:14:29 -0700
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
Date: Wed, 19 Mar 2008 22:14:14 +0000
In-Reply-To: <20080318170019.GA8747@c2.user-mode-linux.org> (Jeff Dike's
	message of "Tue, 18 Mar 2008 13:00:19 -0400")
Message-ID: <87od9apdjd.fsf@hades.wkstn.nix>
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

On 18 Mar 2008, Jeff Dike told this:
> This version keeps track of the time between ticks (as reported by the
> host's gettimeofday) and adjusts its sleeping and reporting ticks
> accordingly.

I can confirm that, as expected, this patch works well enough that
timing problems don't break dhclient anymore (which requires a 2x
oversleep, which you're a long way from now).

At last I can upgrade my firewall :)

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
