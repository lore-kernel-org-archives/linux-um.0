Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzxIx-0005y1-DU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 04:22:51 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Azx3h-0006HW-A0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 04:07:05 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking
References: <200402290158.54770.jdizzl@xs4all.nl>
	<200403071228.15509.blaisorblade_spam@yahoo.it>
	<200403071256.18134.petschge@gmx.de>
In-Reply-To: <200403071256.18134.petschge@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403071312.43183.blaisorblade_spam@yahoo.it>
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
Date: Sun, 7 Mar 2004 13:12:43 +0100
To: petschge@web.de
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 12:56, domenica 7 marzo 2004, Patrick Kilian ha scritto:
> Hi all,
>
> > You refer to bind in the guest, right? Well, you call the
> > socket->ops->bind, while you should probably at least call sys_bind.
>
> Ok. I'll give it a try.
>
> > Your kernel thread is simply a process running in kernel mode - so
> > instead of calling bind(), you just call sys_bind() skipping some
> > useless code (int 0x80, userspace/kernelspace transition and so on).
> > But you cannot, in general, skip anything else unless you have a
> > reason to do so.
>
> I didn't know what the exact difference between bind()
Note also bind() is likely to be bound to the glibc version, and thus operate 
on the host.
>, sys_bind() and
> sockert->ops->bind() was.
>
> > Probably, the same reasoning applies to a lot of other code - why
> > sock_create instead of sys_socket, why sock_recvmsg  ... and so on.
> > Please, at least change both sys_socket and sys_bind before asking
> > again.
>
> Ok the next version will be updated.
>
> > I *do not* understand how ENOENT is actually returned, but probably
> > something that normally fails for a missing file failed for the lack
> > of coherency.
>
> Yeah that could be the reason.
>
> >> Most of the above code should probably be edited with rm
> >
> > What is that? Indentation cleanup?
>
> rm as in "man 1 rm".
Ah, ok :-) I don't agree anyway.

> >> , but you wanted to have my results so far. Now go and find a brown
> >> paper bag.
> >
> > No, do not - seeing the code is very useful indeed.
>
> If you say so...
> I'll give you sugestions a try and be back in some days with Yet Another
> Version of my code.
I've seen it; does it work on your part? I've got a lot less time now for UML, 
so you must be kind with me.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
