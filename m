Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwNKy-00049P-T9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:12:32 -0700
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]
	helo=mail.esperi.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwNKx-0003gs-8F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:12:32 -0700
References: <20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
	<20080509151604.GC10169@c2.user-mode-linux.org>
	<1210353202.31648.8.camel@localhost>
	<20080514172347.GA10283@c2.user-mode-linux.org>
	<1210789757.25724.3.camel@localhost>
	<20080514193912.GA11531@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Wed, 14 May 2008 21:12:12 +0100
In-Reply-To: <20080514193912.GA11531@c2.user-mode-linux.org> (Jeff Dike's
	message of "Wed, 14 May 2008 15:39:12 -0400")
Message-ID: <87r6c4y7ab.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On 14 May 2008, Jeff Dike verbalised:

> I finally reproduced this using 2.6.25.1 (2.6.25-mm1 was no good) with
> your config.

YAY! (I wonder why this was so .config-dependent? You'd think it would
trigger on anything, but I couldn't even make it happen on all my
hosts...)

> The patch below fixes it for me.  You'll notice a certain similarity
> between this and a previous patch that you posted.  It's not clear to
> me why yours didn't work.

As far as I can tell it's identical in behaviour in the !NO_HZ
case.

Annoyingly, now I've upgraded the host to 2.6.25 (hence sans skas3),
timings or something have changed such that I now can't make the freeze
happen at all. I'll reboot the host into 2.6.24.x shortly to get skas
back and try again.


Oh, and, it's pedantic of me, I know, but what does this do if time goes
backwards in the NO_HZ case? (Or is handling that a 2.6.26 thing?)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
