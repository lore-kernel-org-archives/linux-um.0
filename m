Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dqb3j-0002AI-Fu	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 11:25:15 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2-new.sourceforge.net with smtp (Exim 4.44)
	id 1Dqb3f-00058c-OT	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 11:25:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507041853.13469.blaisorblade@yahoo.it>
	<20050707115908.GA6043@ccure.user-mode-linux.org>
In-Reply-To: <20050707115908.GA6043@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072031.31769.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Problems about fork-not-clone (was: Re: [uml-user]
	UML exits after "tracing thread pid")
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
Date: Thu, 7 Jul 2005 20:31:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Oleg Girko <ol@infoserver.ru>

(Oleg, this is about your problem, and there are some questions for you too, 
marked with ////////////////////////////, please ACK me about this message).

On Thursday 07 July 2005 13:59, Jeff Dike wrote:
> > Ok, can you describe it a bit more detailedly?

> > Also, are you going to drop this patch (or allow me to do this) for now?
> > Since it isn't getting fixed, it seems me a good idea.

> I still think the patch is correct.
...
> So, I would say that skas0 is more a fix for this problem than
> reverting the fork-not-clone patch is.
For the question above, and from the "stability" point of view, this does not 
matter, even because this patch is not a bug-fix (Valgrind users can apply it 
manually).

> Ben LaHaise sent me a UML binary 
> which crashes, which I can send you if you want to look at it.
Ok, thanks.
> This thing was looking at errno after the first call to fork even if
> it succeeded.
Were you debugging it? Was it using the "errno" variable or calling, as it 
should have done with normal glibc's, __errno_location()?

> This leads me to believe that this is a compiler oddity 
> rather than a compiler bug, and that this is causing UML to hit the
> tt-specific errno crash with recent libcs.
Mmh, I've read "[uml-user] UML at Fedora Core 4 in TT mode: something wrong 
with errno." from Oleg, and it describes the problem well: errno remains 
forever at 0.

But the return values are not altered, in that case, i.e. failure is failure 
and success is success, just errno is not updated.
> You understand that 
> problem more than I do.
Ok, I've never seen it on my own, but I guess I understand it anyway. The 
problem is that:

a) .thread_private is ignored by NPTL
b) so, while for UML (or at least parts of it) the errno is at one place, for 
the libraries (which are already linked) the real, thread-specific (TLS) 
value of errno is used... and using clone()/fork() interferes with this.

I guess that in NPTL headers, instead of using __errno_location() the faster 
"__thread int errno;" is used; Oleg, can you verify this?
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
> So, I would say that skas0 is more a fix for this problem than
> reverting the fork-not-clone patch is.

Wait a moment, the "errno" problem is fixable and currently it should be 
fixed, for what I can see, the patch is in -rc1... though I have problems 
with this, which could stem from a SYSEMU bug (see other thread "Please test 
2.6.13-rc2 in TT mode!"):

is it possible that after calling mmap2(), the value stored in EBX (i.e. the 
first syscall param) is altered? In fact, this is what seems to happen inside 
switcheroo() to the "to" param, leading to the routine errouneously failing. 
This does not happen anywhere else in the UML kernel, it seems.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
