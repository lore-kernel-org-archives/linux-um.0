Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Werner Almesberger <wa@almesberger.net>
Message-ID: <20041019020055.A31791@almesberger.net>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410190023.14067.blaisorblade_spam@yahoo.it>;
	from blaisorblade_spam@yahoo.it on Tue, Oct 19, 2004 at
	12:23:14AM +0200
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
Date: Tue, 19 Oct 2004 02:00:55 -0300
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

BlaisorBlade wrote:
> Can you try using SIGCONT, please? Even the patch changelog clearly says that 
> you must kill -CONT before kill -KILL

That looks like a race condition. If the process manages to enter
the same state again before you get to KILL it, even this "advanced"
kill is lost.

> (actually, a kill -CONT may make the process notice the SIGKILL),

That's what works so far, yes. I'm actually no quite certain what
this thread is about: it sounds as if this was a new problem, but
we've required CONT with KILL in some cases already for a long
time.

> Quite frankly, I do not know the question myself - but people 
> seem to agree that this is a correct behaviour.

The odd thing is that a process that was ptraced but whose ptracer
is long dead *still* needs the CONT. That doesn't look right to me.

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
