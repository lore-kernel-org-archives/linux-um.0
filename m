Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgoBu-0001IZ-6y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:20:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BgoBt-0001lD-LU for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:20:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
References: <20040629182711.GM5243@alcor.net>
	<200406302038.41475.blaisorblade_spam@yahoo.it>
	<20040701230225.i4p20wsc080g04oc@www.wagland.net>
In-Reply-To: <20040701230225.i4p20wsc080g04oc@www.wagland.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200407031921.38522.blaisorblade_spam@yahoo.it>
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
Date: Sat, 3 Jul 2004 19:21:37 +0200
Content-Transfer-Encoding: 8bit
To: Paul Wagland <paul@wagland.net>
Cc: James Neal <jneal@nks.net>, Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 256873-forwarded@bugs.debian.org, Marius Gedminas <mgedmin@b4net.lt>

Alle 23:02, giovedì 1 luglio 2004, Paul Wagland ha scritto:
> On Wed 30 Jun 2004 20:38:41 CEST, BlaisorBlade wrote:
> > Alle 09:56, mercoled? 30 giugno 2004, Paul Wagland ha scritto:
> >> On Jun 30, 2004, at 1:55, James Neal wrote:
> >>
> >> I normally hate doing this... but me too!
> >>
> >> Even worse, it would appear that UML and reiserfs don't play nice...
> >> when the UML does crash I tend to end up with some pretty massive
> >> filesystem corruptions, to the point where my UML will not boot
> >> anymore, and I spent over an hour just now trying to coax it back to
> >> life by copying in and replacing all of the corrupted binaries.
> >
> > If you didn't enable the synchronous UBD access (near to the UBD options
> > in the kernel configuration), that's almost expected, as the help
> > explains (IIRC), for journaled filesystems (although some people claim
> > ext3 does not need it, and this could be true, even because reiserfs
> > works like ext3 "data=writeback" mode, which is less safe than the
> > default ext3
> > "data=ordered").
>
> Ah. Ok, I assume by this you mean that I should be doing ubd1s=blah instead
> of ubd1=blah. I will try that, it looks like it should at least stop the fs
> screwage. On a different sidenote, what is the "recommended" filesystem for
> UML?

Well, I speak about CONFIG_BLK_DEV_UBD_SYNC (Always use synchronous access for 
UBD), but maybe what you suggest is the same thing (the kernel option would 
turn "s(ync)" on for all UBDs, maybe).

I've no idea of a "recommended" filesystem; I only know that ext3 *seems* not 
to require that UBD are accessed in a synchronous way. (I.e. somebody says he 
never experienced data loss with ext3 with async UBDs).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
