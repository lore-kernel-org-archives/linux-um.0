Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BT8AF-0007Mb-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 16:50:27 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BT8AE-00066f-Cz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 16:50:26 -0700
Message-ID: <0ed301c4437d$378dcf30$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <40686E7D.2080600@unclewebster.com>
	<200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
	<200404111651.20256.blaisorblade_spam@yahoo.it>
Subject: update on cowlinks - was: Re: [uml-devel] Re: [uml-user] one drawback
	to using cows commercially...
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 27 May 2004 01:57:34 +0200
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>, tim doyle <tim@unclewebster.com>
Cc: UML <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

http://lwn.net/Articles/83790/
http://wohnheim.fh-wedel.de/~joern/cowlink/

----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "Jeff Dike" <jdike@addtoit.com>; "tim doyle" <tim@unclewebster.com>
Cc: "UML" <user-mode-linux-user@lists.sourceforge.net>; <user-mode-linux-de=
vel@lists.sourceforge.net>
Sent: Sunday, April 11, 2004 4:51 PM
Subject: [uml-devel] Re: [uml-user] one drawback to using cows commercially=
...


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

Have you heard of the discussion about COWlinks? I.e. creating a Copy - On -
Write functionality for hard links? Or do you want to rewrite files one page
at a time (i.e. if I change one byte inside a file, only the "page"
containing that byte is copied and changed)?

http://lwn.net/Articles/77215/

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
