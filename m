Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFEKj-00076h-E5 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 08:35:49 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BFEKi-0002Kd-VP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 08:35:49 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] Fix for annoying problem with hostfs
	readdir problems.
References: <20040415210318.GA205486@linuxhacker.ru>
	<20040415214629.GB207748@linuxhacker.ru>
In-Reply-To: <20040415214629.GB207748@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404181726.23698.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Apr 2004 17:26:23 +0200
Content-Transfer-Encoding: quoted-printable
To: Oleg Drokin <green@linuxhacker.ru>, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

Alle 23:46, gioved=EC 15 aprile 2004, Oleg Drokin ha scritto:
> Hello!
>
> On Fri, Apr 16, 2004 at 12:03:18AM +0300, Oleg Drokin wrote:
> >    So the annoying problem with readdir not working on hostfs (on 2.6
> > host kernel only for me) was finally hunted to memory allocation
> >    problem during opendir.

I've experienced it too onto 2.6 and someone else had the same problem - bu=
t=20
that patch is not perfect. Using always vmalloc() instead of kmalloc() is=20
wrong - vmalloc is slower, and Linus spoke against vmalloc(); it would also=
=20
slow down everything using malloc().

Probably you should use vmalloc() only if size is > the size limit (if this=
 is=20
the problem, as I guess). When you come at free() it is a bit hard, but IIR=
C=20
vmalloc() can return pointers inside a certain, known memory area, right? S=
o=20
it is possible to understand what function to call.

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
