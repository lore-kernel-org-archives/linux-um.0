Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRqG5-0004EO-Kq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:31:09 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRqG4-00007m-Uq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:31:09 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] preemption
References: <20040518134726.36369.qmail@web14002.mail.yahoo.com>
	<20040518183838.GA29175@ccure.user-mode-linux.org>
In-Reply-To: <20040518183838.GA29175@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200405231118.44464.blaisorblade_spam@yahoo.it>
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
Date: Sun, 23 May 2004 11:18:44 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:38, marted=EC 18 maggio 2004, Jeff Dike ha scritto:
> On Tue, May 18, 2004 at 06:47:26AM -0700, Sam King wrote:
> > >From what I can tell, when the guest kernel takes a
> >
> > timer interrupt (SIGALRM) it eventually updates the
> > tsk->need_resched parameter for processes that have
> > been running for too long.  However, I do not see
> > where the actual switch takes place except in the
> > interrupt_end() function which is only called as a
> > result of guest application system calls and signals.
>
> Exactly.  Every kernel entrance is either a system call or signal (a UML
> signal, not a process signal, BTW), so there is a preemption opportunity
> at every return to userspace.
But when you say "UML signal" (I guess a signal between the host UML thread=
s)=20
you mean even a timer interrupt, right? Otherwise I don't see how a=20
non-syscalling process (a true CPU-hog, like SETI@home or such things) coul=
d=20
be interrupted.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
