Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcpvj-0000N3-8q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 11:23:35 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Bcpvh-0001yX-Sz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 11:23:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] hostfs / current->fsuid
References: <20040621034434.GC2735@thump.bur.st>
	<20040622135044.GG25291@patrick.wattle.id.au>
In-Reply-To: <20040622135044.GG25291@patrick.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406222035.06782.blaisorblade_spam@yahoo.it>
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
Date: Tue, 22 Jun 2004 20:35:06 +0200
Content-Transfer-Encoding: quoted-printable
To: Cameron Patrick <cameron@patrick.wattle.id.au>, Trent Lloyd <lathiat@bur.st>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 15:50, marted=EC 22 giugno 2004, Cameron Patrick ha scritto:
> Hi Trent,
>
> Since no-one else has answered yet, I'll have a shot...
>
> On Mon, Jun 21, 2004 at 11:44:35AM +0800, Trent Lloyd wrote:
> | I was looking into trying to modify hostfs so if UML ran as root it
> | would keep the same permissions
>
> I've no idea about modifying hostfs, but have you looked into using
> NFS instead?  Sure, it's a security nightmare, but it can't be worse
> than running UML as root!  Performance might suck though.

No, on the uml-user list there are some reports NFS is faster than hostfs (=
not=20
actual benchmarks, just feelings): I think that this can be true due to the=
=20
super-optimization of NFS gone in for years; also it's difficult to optimiz=
e=20
something when you cannot use inline functions for some things (i.e. the=20
distinction between userspace and kernelspace files).

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
