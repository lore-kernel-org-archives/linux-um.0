Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJwCu-0008Gk-4t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 08:47:28 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CJwCt-0002mX-FY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 08:47:28 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
References: <4173F1FD.6080004@colitti.com>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<20041019020055.A31791@almesberger.net>
In-Reply-To: <20041019020055.A31791@almesberger.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410191747.49906.blaisorblade_spam@yahoo.it>
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
Date: Tue, 19 Oct 2004 17:47:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Werner Almesberger <wa@almesberger.net>, user-mode-linux-user@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Tuesday 19 October 2004 07:00, Werner Almesberger wrote:
> BlaisorBlade wrote:
> > Can you try using SIGCONT, please? Even the patch changelog clearly says
> > that you must kill -CONT before kill -KILL
>
> That looks like a race condition.

> If the process manages to enter 
> the same state again before you get to KILL it,
Why? This does not make sense, IMHO - after a SIGCONT it should keep running  
until something *requests* it stopping - or not? I'm not finding a clue in 
the sources... it's quite difficult.
> even this "advanced" 
> kill is lost.

> > (actually, a kill -CONT may make the process notice the SIGKILL),

> That's what works so far, yes. I'm actually no quite certain what
> this thread is about: it sounds as if this was a new problem, but
> we've required CONT with KILL in some cases already for a long
> time.

> > Quite frankly, I do not know the question myself - but people
> > seem to agree that this is a correct behaviour.

> The odd thing is that a process that was ptraced but whose ptracer
> is long dead *still* needs the CONT. That doesn't look right to me.
I remember that on Slackware, when doing "init 1" it sends even kill -CONT to 
all processes, so either they think it's correct or they want to workaround 
an issue existing for lots of kernel releases.

Bye
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
