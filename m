Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRbRv-0003Eu-Af for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:14:39 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CRbRu-0007bU-FS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:14:39 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re:
	[patch 09/20] uml: use SIG_IGN for empty sighandler)
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
	<200411091844.44218.blaisorblade_spam@yahoo.it>
	<200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
In-Reply-To: <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411092015.10544.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Nov 2004 20:15:10 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, cw@f00f.org

On Tuesday 09 November 2004 21:48, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > I also understand now what all this is for. When I have time for this,
> > I'll at  least copy and paste your mail into a comment, with any
> > needed adjustment.

> That would be a good idea.

> > For the semaphore issue, I have some ideas (like using futexes) which
> > need to  be developed a bit:

> > 1) I want to create a semaphore API in os_*.
> > 2) It will be able to use socketpairs.
> > 3) It will be able to use futexes, if they are
> > non-persistant and usable  without too much issues (the same way we
> > are going to support Async I/O).
> > 4) It will be used first by the code
> > which could really benefit from the  performance increase.
> > 5) It won't
> > use persistant objects.

> This all sounds good, although there are simplicity benefits to just using
> one underlying mechanism, as long as there are no overriding disadvantages
> to it.
Yes, I would like that, too, but futexes are 2.6 only, and probably also 
NPTL-only (we are going to fix that, at least for SKAS mode), but faster than 
anything else. Nothing apart this.

> > Any comment on these issues? Also, apart TT context switching, is
> > there any  other performance-sensitive use of semaphores, which would
> > benefit from using  futexes?

> Offhand, I think context switching is the most sensitive one.
Ok. But to get TT mode to work against NPTL glibc, which is required for 
futexes, we need to recode the "thread_private" section in uml.lds.S to work 
with NPTL glibc. It seems that binutils does not like that (the error is "not 
enough program header allocated", which refers to the fact that 
SIZEOF_HEADERS is guessed and then used. Not using SIZEOF_HEADERS could help, 
if doing this is possible).

> > Yes, semget and friends are uglier.
> > But don't think that the current nested code is simple to read - three
> >  semaphores at a time, without a clear name, are not the clearer code
> > on the  world.

> What nested code are you talking about?

There are two down() and two up(); additionally, run_helper_thread() manages 
at least another pipe(). I don't see an easy way to simplifying all this, but 
it's needed (or at least some comment should be added). Just a cleanup, 
anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
