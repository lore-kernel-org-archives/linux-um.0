Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVa2p-00013p-At for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 11:00:55 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BVa2o-0006fv-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jun 2004 11:00:54 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] mlock discussion is back - was: Re: [uml-user] odd
	ping problems
References: <pan.2004.05.17.20.30.18.825415@sipsolutions.de>
	<002101c4434a$ad9cc5b0$0201a8c0@hawk>
	<0e6d01c44378$7a05e640$2000000a@schlepptopp>
In-Reply-To: <0e6d01c44378$7a05e640$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200406021258.56597.blaisorblade_spam@yahoo.it>
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
Date: Wed, 2 Jun 2004 12:58:56 +0200
Content-Transfer-Encoding: quoted-printable
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, matthew-list@bytemark.co.uk, michel@pollet.net, Jeff Dike <jdike@addtoit.com>

Alle 01:23, gioved=EC 27 maggio 2004, roland ha scritto:
> for at least two of the uml-pid`s you should see minor and major pagefaul=
ts
> (minflt/majflt) - i would say there is a releationship between those
> pagefaults and the ping delays. (i had turned off swap completely - so my
> host was not able to swap at all!)

That is not very good - if the latency problem comes from UML being swapped=
=20
out, why do you disable swapping? Actually there is some "swapping", in a=20
certain sense, so you could observe the major page faults (major means=20
"requiring I/O", minor means "no IO": this can happen for COW pages, to mar=
k=20
as dirty a clean page).

When swapping is disabled, the pages belonging to a memory mapping, that wa=
s=20
not modified since they were read from the disk, can be swapped out.

I.e. the executable pages, actually, are created by mmap'ing the executable=
;=20
since they are not modified, they can be removed from memory.

Also the data pages which come from the executable can be treated the same =

way, if they are still "clean" (i.e. not modified).

[ I actually checked the code works this way, i.e. if you try to read a glo=
bal=20
var, even if it's mmaped with PROT_WRITE, in the page-tables it is marked a=
s=20
read-only; when you try to write it, it will be marked as read-write and th=
e=20
page will become dirty. ]

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
