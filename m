Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNBi-00062L-AL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:18:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BfNBh-0003nm-NL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:18:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] host and uml kernel with grsec
References: <20040628213232.GH1583@paprika.budape.st>
In-Reply-To: <20040628213232.GH1583@paprika.budape.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406292031.26438.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 20:31:26 +0200
Content-Transfer-Encoding: quoted-printable
To: Tom Rottler <tom@multip.hu>, user-mode-linux-devel@lists.sourceforge.net

Alle 23:32, luned=EC 28 giugno 2004, Tom Rottler ha scritto:
First: thanks a lot!

> Still TO DO:
> * I have a working grsec enabled uml kernel, based on the uml patch
>   of Thomas Fischbacher, which you can find at the same web site.
>   I am going to create a patch that leads to my grsec-uml kernel,
>   this will take another few days due to lack of free time.

> * Build a devanon patch for the host kernel. There is for example a
>   collision on a minor device number between grsec and devanon.
You can freely change the minor in mem.c for devanon patch, as long as you =

update it in the host filesystem device node; but devanon patch is a bit=20
broken (somebody reported panics with it), so be careful with the patch.

> * Testing, testing, testing! I am not a kernel hacker, so probably
>   I introduced severe bugs with my patch. Be very careful with it!!!
Be careful to avoid dropping security checks! I remember that someone poste=
d a=20
patch (against Gentoo sources which include GrSec, to find it) having a suc=
h=20
problem, IIRC.
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
