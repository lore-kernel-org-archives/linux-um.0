Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Azwbu-0004Z7-W4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:38:22 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AzwMg-0001fc-0C for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:22:38 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking
References: <200402290158.54770.jdizzl@xs4all.nl>
	<200403021909.47013.blaisorblade_spam@yahoo.it>
	<200403022240.25616.petschge@gmx.de>
In-Reply-To: <200403022240.25616.petschge@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403071228.15509.blaisorblade_spam@yahoo.it>
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
Date: Sun, 7 Mar 2004 12:28:15 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Patrick Kilian <petschge@gmx.de>

Alle 22:40, marted=EC 2 marzo 2004, Patrick Kilian ha scritto:
> Hi all,
>
> Am Dienstag, 2. M=E4rz 2004 19:09 schrieb BlaisorBlade:
> >> Well bind is returning -2 which seams to be -ENOENT. Does somebody
> >> know why this happens?
> >
> > Hmm, I'm no expert with sockets; possibly the folder in which you
> > create the socket does not exist. However, possibly code it like a
> > normal program which just opens the socket and calls bind() and try
> > it.
>
> No the folder exists and is on a rw filesystem. This problem was the reas=
on
> why I abandond the the driver the first time.

You refer to bind in the guest, right? Well, you call the socket->ops->bind=
,=20
while you should probably at least call sys_bind.

Your kernel thread is simply a process running in kernel mode - so instead =
of=20
calling bind(), you just call sys_bind() skipping some useless code (int=20
0x80, userspace/kernelspace transition and so on). But you cannot, in=20
general, skip anything else unless you have a reason to do so.

Probably, the same reasoning applies to a lot of other code - why sock_crea=
te=20
instead of sys_socket, why sock_recvmsg  ... and so on. Please, at least=20
change both sys_socket and sys_bind before asking again.

I *do not* understand how ENOENT is actually returned, but probably somethi=
ng=20
that normally fails for a missing file failed for the lack of coherency.

> Most of the above code should probably be edited with rm
What is that? Indentation cleanup?
> , but you
> wanted to have my results so far. Now go and find a brown paper bag.

No, do not - seeing the code is very useful indeed.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
