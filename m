Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
Message-ID: <20041019175844.GA13118@bytesex>
References: <4173F1FD.6080004@colitti.com>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<20041019020055.A31791@almesberger.net>
	<200410191747.49906.blaisorblade_spam@yahoo.it>
	<20041019131553.A18872@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019131553.A18872@almesberger.net>
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
Date: Tue, 19 Oct 2004 19:58:44 +0200
To: Werner Almesberger <wa@almesberger.net>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Tue, Oct 19, 2004 at 01:15:53PM -0300, Werner Almesberger wrote:
> BlaisorBlade wrote:
> > Why? This does not make sense, IMHO - after a SIGCONT it should keep running  
> > until something *requests* it stopping - or not?
> 
> Well, depends on what constellation we have: if the ptracer is
> already dead, this should work.

It's alive.

> If the ptracer is still alive, we may return to the same state quickly
> (e.g. if both sides aren't interactive anyway).

Or if the uml kernel scheduler decides the task should go sleep again
and sends a SIGSTOP for that ...

> Of course, one could argue that, in the latter case, allowing the
> ptracer to override SIGKILL is a feature (in any case, the ptracer
> should be able to keep the dying process for examination).

Yep, but if you want to allow the ptracer override SIGKILL you should
at least notify it about the SIGKILL, which doesn't happen either in
2.6.9-rc2+ ...

> > I remember that on Slackware, when doing "init 1" it sends even kill
> > -CONT to all processes, so either they think it's correct or they
> > want to workaround an issue existing for lots of kernel releases.
> 
> My bet would be on the workaround :-)

Oh well.  As far I can see there is no simple, race-free workaround.
Guess we really have to find that damn bug ...

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
