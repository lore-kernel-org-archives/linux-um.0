Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5pQu-0007Ce-PZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 10:43:39 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C5pQb-0001Vq-Ig for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 10:43:22 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML hanging while deactivating swap
References: <chao0q$ajs$1@sea.gmane.org>
	<200409100356.i8A3uQg1005723@ccure.user-mode-linux.org>
	<41411B7B.5060300@upb.de>
In-Reply-To: <41411B7B.5060300@upb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409101936.46107.blaisorblade_spam@yahoo.it>
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
Date: Fri, 10 Sep 2004 19:36:46 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, Jeff Dike <jdike@addtoit.com>

On Friday 10 September 2004 05:11, Sven K=F6hler wrote:
> >>ubd1 of my UML is a swapfs, and when halting or rebooting it, it hangs
> >> while the swap is deactivated (i guess swapoff -a is executed).
> >
> > Can you narrow it down within the shutdown process?  Adding -x to the #!
> > lines of the relevant scripts is a good way to do this.
>
> the relevant lines of the init script are
>
> if [ -n "`swapon -s 2>/dev/null`" ]
> then
>          ebegin "Deactivating swap"
>          swapoff -a &>/dev/null
>          eend $?
> fi
>
> so it _must_ be the "swapoff -a" since i see the "Deactivating swap"
> message, but not the "OK" that eend would generate.

No, the message could be generated but the console not flushed.

However, I think you should manually comment out the "swapoff" line and ret=
ry.=20
You will maybe discover that is not a fix. Someone else had problems with=20
hwclock, instead, so you try this, too.

> > Also, can you get a stack trace from UML?
>
> I don't know how to do that, sorry :-(. I have never worked with gdb and
> suchlike, but i'd really like to help to track the error down somehow.
>
> The UML seems to be still running, since it takes CPU-time on the host,
> but the swapoff seems to never return.
>
> It also hard for me to reproduce this, but i think it only happens when
> swap is used. If i try to reproduce it by running some programs that use
> much memory and therefor things get swapped, the UML halts without
> problems. Other UMLs that ran for months and have about 1MB swap used
> hang while the swap gets deactivated.
Could it be because there is not enough free memory to free the swap?

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.=20
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
