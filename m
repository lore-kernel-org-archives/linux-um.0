Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJftr-00016m-DY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 15:22:43 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CJftq-0005sA-OT for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 15:22:43 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
In-Reply-To: <20041018212612.GA3052@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410190023.14067.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Host processes never terminate on 2.6.9rc3
	host (stuck in ptrace_stop)
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
Date: Tue, 19 Oct 2004 00:23:14 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Monday 18 October 2004 23:26, Gerd Knorr wrote:
> > > Yes, I see that as well, it actually *is* that ptrace change added in
> > > patch-2.6.9-rc1-bk16.
> > >
> > > IMHO it is a bug, I've reported it to lkml a
> > > few days ago, no response yet.
> >
> > Oh well, did I lost it or you did not CC the UML mailing list? And in the
> > 2nd case, why?

> I didn't cc the uml list as it isn't a uml bug, its just that uml
> triggeres it.
Hmm - trying to fix that or just reverting the patch inside the SKAS patch (or 
as attached patch) would have been a possible workaround.
> > I'm downloading the patches from BitKeeper.
>
> I'll attach the offending one for reference, also a short test app
> showing the buggy behavior.

> > > Problem is that you can't kill -9 processes any more which are ptraced
> > > _and_ stopped at the same time.
> >
> > Sorry, tried kill -CONT? I'm almost sure it works (tried by both Henrik
> > Normstrod and me, not in this case).

> IMHO it is a clear bug in the (host) kernel, so I didn't attempt yet to
> workaround that by playing tricks in the UML kernel.  I can't see the
> bug when reading the patch through, probably the separation of stopped
> and traced process states triggeres some odd corner case somewhere else
> in the kernel ...
>
> If you send a SIGKILL to the process being stopped & ptraced *nothing*
> happens.  Neither the process is killed nor the ptracing parent is
> notified.  That can't be correct.

Can you try using SIGCONT, please? Even the patch changelog clearly says that 
you must kill -CONT before kill -KILL (actually, a kill -CONT may make the 
process notice the SIGKILL), and that behaviour can be reproduced, I think, 
on every kernel version. There has been a thread on this (t-mode processes) 
on uml-devel. Quite frankly, I do not know the question myself - but people 
seem to agree that this is a correct behaviour.

That said, I'll give a look to the patch. Have you CC'ed the patch author on 
your report?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
