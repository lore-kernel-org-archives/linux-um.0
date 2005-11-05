Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYD88-0002uv-Ql for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 17:46:04 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYD88-0005aY-Ej
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 17:46:04 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511041441.11896.rob@landley.net>
	<200511050042.49904.blaisorblade@yahoo.it>
In-Reply-To: <200511050042.49904.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041945.53507.rob@landley.net>
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
Date: Fri, 4 Nov 2005 19:45:53 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 04 November 2005 17:42, Blaisorblade wrote:
> > That's more configuration on the host that's not really needed.  Doesn't
> > do my case any good.
>
> We'll consider your case too then... for your job the daemon could be done
> by a thread started by UML on the host. The idea (still very preliminar)
> was conceived for hosting providers, to my knowlegde.

If I don't have to run it, I don't mind.  However, keep in mind I get runaway 
UML threads left after UML theoretically exits on a fairly regular basis.  
(Haven't banged on 2.6.14 so much, dunno if it still does that.)  Due to the 
fact the process's name has been replaced with random memory, I can't 
"killall" the bastards, I have to manually go in and track them down by hand, 
which sucks and can't be scripted.  Sometimes they're leftover stopped 
processes that I have to kill -CONT after I kill them to make them go away.  
(Personally, I consider that a kernel bug.  kill -9 will kill anything, 
except a stopped process...)

> > If we get prezeroing, the tunable is useful.  If we haven't got
> > prezeroing, this infrastructure probably won't get in.
>
> Hmm.... yep, prezeroing is useless if you don't keep some prezeroed memory,
> right.... I had answered too much in a hurry.
>
> Btw, indeed I previously planned to use the existing arch_free_pages() hook
> for page freeing, to call madvise() (conditionally I mean)... actually yes,
> you can't make sure that page isn't going to be reused, but if the page is
> _freed_ and you want still the content kept you will _anyway_ loose.
>
> The biggest risk is to madvise() a page uselessly, and that disturbs a bit
> performance, except that in general we should win by letting the host use
> more memory.

Another advantage of prezeroing: it maps really well to what we're trying to 
do here.  It makes a class of not just free but zeroed memory (and madvise 
zeroes the memory for us).  The decision of how _much_ memory to keep away 
from the page cache already has to be dealt with (and if it's tuneable we can 
reap the page cache viciously in UML).  In theory we'd want to keep some 
"free" memory back from being zeroed so we don't thrash with the host OS, but 
that might not be too hard.

Without prezeroing, it's more work.  Not quite sure how much more because the 
vm has changed a lot since I last believed I understood it...

> a Windows client via Putty and Cygwin/X from my laptop. Ah, sorry, I'm
> indeed doing this...

Back under OS/2 I once ran Win/OS2, brought up its dos box, and ran a 
commodore 64 emulator in it.  Because I could.  (Don't remember if I managed 
to shoehorn desqview in there, but if so it wasn't from lack of trying.)

> >  The fact my old
> > ubuntu's on a 2.6.10 kernel might have something to do with it, though...
> >
> > > Yep, I see - it becomes so reluctant to swapping that it prefers
> > > killing. Unintended, but at least a reasonable bug...
> >
> > Triggering the OOM killer when you have _any_ writes pending is silly.
>
> Hey, I said "reasonable bug", but don't forget "bug" in the sentence. It's
> reasonable as opposed to "busybox install doesn't work in UML", which is an
> unreasonable bug.

Busybox install does work in UML, though.  I've done it. :)

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
