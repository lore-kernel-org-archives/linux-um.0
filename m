Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BChmK-0006BO-Lw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Apr 2004 09:25:52 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BChmJ-0005Di-Vk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Apr 2004 09:25:52 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <40686E7D.2080600@unclewebster.com>
	<200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
In-Reply-To: <200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404111651.20256.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] one drawback to using cows commercially...
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
Date: Sun, 11 Apr 2004 16:51:20 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, tim doyle <tim@unclewebster.com>
Cc: UML <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

Alle 04:17, marted=EC 30 marzo 2004, Jeff Dike ha scritto:
> tim@unclewebster.com said:
> > Is there any clever way to reset the root password for users, aside
> > from  deleting the cow? "linux single" is fine, but aside from that?
>
> I'm finishing up a new hostfs-like filesystem which I want to become the
> preferred mechanism to boot UMLs because of its ability to mmap data from
> the host, eliminating duplicate copies of file data in memory.
>
> A side-effect of this is that UML filesystems will become visible on the
> host, so password changing would be a matter of chrooting to the filesyst=
em
> and running passwd.
>
> Currently, there is no COW functionality, but I plan to add file-level
> COWing with block-level COWing possibly following later.

Have you heard of the discussion about COWlinks? I.e. creating a Copy - On =
-=20
Write functionality for hard links? Or do you want to rewrite files one pag=
e=20
at a time (i.e. if I change one byte inside a file, only the "page"=20
containing that byte is copied and changed)?

http://lwn.net/Articles/77215/

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
