Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwNdW-0006AT-Rn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:31:43 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user92331)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwNdU-0005EE-2E
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 13:31:42 -0700
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
	<87r6c4y7ab.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Wed, 14 May 2008 21:31:31 +0100
In-Reply-To: <87r6c4y7ab.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Wed, 14 May 2008 21:12:12 +0100")
Message-ID: <87mymsy6e4.fsf@hades.wkstn.nix>
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

[vincent-perrier <vincent-perrier@club-internet.fr> removed from Cc;,
 his MTA says `Client host rejected: AP0002 Please use your ISP mailserver'
 only I don't *have* an ISP mailserver.]

On 14 May 2008, nix@esperi.org.uk verbalised:
> Annoyingly, now I've upgraded the host to 2.6.25 (hence sans skas3),
> timings or something have changed such that I now can't make the freeze
> happen at all. I'll reboot the host into 2.6.24.x shortly to get skas
> back and try again.

It seems to fix it with a 2.6.24 host too, but I still can't see why it
works when my previous fix didn't. (Actually, while I'm trying it with
lots of differently mangled variations on a host .config theme, is there
a skas3 or skas4 against 2.6.25? I may as well add that into the mix and
see if things still work.)

I'll keep ntpd running here for a day or so as well, and see if it stalls
out. (The host loses nearly half a minute a day without ntpd, it's
awful.)

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
