Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApveF-0000lq-N7
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:35:23 -0800
Received: from danga.com ([66.150.15.140])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApveD-0006vo-Vx
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 12:35:22 -0800
From: Brad Fitzpatrick <bradfitz@livejournal.com>
In-Reply-To: <200402071955.58659.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.55.0402081230100.9976@danga.com>
References: <200402071955.58659.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: InnoDB and /proc/mm
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 8 Feb 2004 12:35:18 -0800 (PST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

I've only looked at the Windows AWE API briefly, and how InnoDB uses it,
but I believe InnoDB already has the support for storing data (its buffer
pool pages) within different 4GB address spaces.  I never thought
/proc/mm let you create 36-bit address spaces... I knew it was limited to
4GB.

And however heavy /proc/mm is, it can't be slower than making InnoDB
go to disk for the data.  (well, in reality the kernel's buffer pool would
cache things too, but it'd throw off InnoDB's stats a bunch, and the
kernel couldn't do quite as good as job....)

In any case, we're only buying 64-bit machines for our new database
servers, but we have a bunch of 32-bit machines with lots of memory that I
wish we could use InnoDB effectively on.  If anybody is interested in
investigating this more as a possible contract project, let me know.

- Brad


On Sat, 7 Feb 2004, BlaisorBlade wrote:

> I've read your page at http://brad.livejournal.com/1968050.html, and was
> attracted by it since I'm studying Uml internals. However, since I've read a
> lot of times that patch, I can give you some suggestion about it.
>
> What it does is simply to allow one process (let's call it the *kernel*
> process, referring to UML) to create more virtual address spaces for only one
> process (let's call it the userspace one). It accomplishes this by ptracing
> the child and making some special requests.
>
> Not arbitrary ones (they obey all the rule that a normal address space has),
> as you say. On your page it seems that /proc/mm enables apps to create a
> 36-bit address space; maybe I just don't get you right, but you say exactly
> this at least about Windows AWE API. Which is not right. Keep reading,
> however, as there is (maybe) a way to use it.
>
> The reason for this is that the userspace process will have one address space
> when running pid 1 inside UML, another while running pid 2 inside UML and so
> on (the userspace thread just runs the code of processes inside UML). Those
> address space are also unrelated (they can decide to share pages, yes, by
> mmaping a common file, which can be on a tmpfs, i.e. in RAM; currently there
> is no other way of creating shared memory between them).
>
> Then, with the SKAS patch you can say: well, I create 10 address spaces of 3
> Gigas, and I make one InnoDB process (I don't think one thread) switch back
> and forth between them, to keep the various datas. 30 Gigas total.
> If you mean this, you are right. But that's *very* hard to do, since when you
> use one of the address spaces, you can't use the other one. So if you must
> use datas scattered between them, that's a real pain.
> Also, I'm not that sure that the overhead for /proc/mm is so little that you
> get a performance gain. The "user" thread can't directly change its address
> space; it is the "kernel" thread which must do this (as of now; this maybe
> could be changed, if you find anyone able to do it).
>
> Regards
> --
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
>
>


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
