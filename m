Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuZH9-0002L6-1e for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 13:33:07 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user8989)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuZH7-0003Mn-I2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 13:33:06 -0700
References: <20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
	<20080509151604.GC10169@c2.user-mode-linux.org>
	<1210353202.31648.8.camel@localhost>
From: Nix <nix@esperi.org.uk>
Date: Fri, 09 May 2008 21:32:54 +0100
In-Reply-To: <1210353202.31648.8.camel@localhost>
	(vincent-perrier@club-internet.fr's message of "Fri,
	09 May 2008 19:13:22 +0200")
Message-ID: <87fxsr9q15.fsf@hades.wkstn.nix>
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

On 9 May 2008, vincent-perrier@club-internet.fr verbalised:
> The download is long, the untar too, but the freeze is garanteed!

If this doesn't work I can give you an account on, hm, the box which
freezes uses a UML for its network link so if you flip the time on it
you'd get cut off... and on the other machine it doesn't freeze at all,
even if I slam the time backwards and forwards in 5s increments
constantly.

I wonder if I have to be pushing network packets around or something
before it goes wrong? (I can certainly send you the binary that's going
wrong for me, and induce a core dump when it's gone wrong and send you
that: it'll be 90Mb+ though. I'm not sure how useful that is.)

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
