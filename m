Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
Message-ID: <20041019131553.A18872@almesberger.net>
References: <4173F1FD.6080004@colitti.com>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<20041019020055.A31791@almesberger.net>
	<200410191747.49906.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191747.49906.blaisorblade_spam@yahoo.it>;
	from blaisorblade_spam@yahoo.it on Tue, Oct 19, 2004 at
	05:47:49PM +0200
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
Date: Tue, 19 Oct 2004 13:15:53 -0300
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

BlaisorBlade wrote:
> Why? This does not make sense, IMHO - after a SIGCONT it should keep running  
> until something *requests* it stopping - or not?

Well, depends on what constellation we have: if the ptracer is
already dead, this should work. If the ptracer is still alive, we
may return to the same state quickly (e.g. if both sides aren't
interactive anyway). Of course, one could argue that, in the
latter case, allowing the ptracer to override SIGKILL is a
feature (in any case, the ptracer should be able to keep the
dying process for examination).

Part of the problem is of course that there's no clear and
comprehensive definition of what ptrace should do. It would be
nice if the POSIX folks would tackle this :)

> I'm not finding a clue in the sources... it's quite difficult.

Yeah, when I spotted it in 2.5.44, I didn't have the stomach to
actually fix it either, and just reported it, hoping that some
other brave soul would step up. That was about 1.5 years ago :-(

> I remember that on Slackware, when doing "init 1" it sends even kill -CONT to 
> all processes, so either they think it's correct or they want to workaround 
> an issue existing for lots of kernel releases.

My bet would be on the workaround :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
