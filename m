Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Auzma-0007xj-Ca for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 12:00:56 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuzUj-0007Ec-10 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 11:42:29 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] new skas3 patch ready for 2.4.25
References: <40338C1B.1070800@meisterwerk.net>
	<200402221516.09898.blaisorblade_spam@yahoo.it>
	<87u11jrnwk.fsf@amaterasu.srvr.nix>
In-Reply-To: <87u11jrnwk.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402222056.30704.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 22 Feb 2004 20:56:30 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:04, domenica 22 febbraio 2004, Nix ha scritto:
> On Sun, 22 Feb 2004, BlaisorBlade said:
> > Hmmm, I've looked at the faulting code and IMHO the most probable thing
> > is a compilation problem (forgot make dep after applying the patch, for
> > instance) - try saving your .config, running make mrproper,
> > grepping through .config to check that CONFIG_PROC_MM=y and recompiling
> > the bzImage:
> >  $ make dep bzImage
>
> It's highly plausible that exactly that happened: I forgot `make
> oldconfig' during the first build and assumed (ha!) that `make dep'
> would fix everything up OK so that a config change would trigger
> rebuilds appropriately. Possibly this was a foolish assumption and a
> `make dep clean' was necessary.

When analyzing your bug I was really astonished - I thought at a such scenario 
( 1st build without CONFIG_PROC_MM created ptrace.o but then failed - config 
updated - rebuild all but ptrace.o is not rebuilt) and posted my answer in 
that hypothesis, but I thought that was too hard to trigger and that I had 
made some errors.

Make dep should have fixed things, so it's not your fault, but in this case it 
didn't - sometimes happens in 2.4 builds. Luckily, 2.6 finally fixed this (at 
least for what I've heard and for my personal experience).

Good bye and best wishes for your new kernel!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
