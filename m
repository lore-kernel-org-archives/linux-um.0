Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsOXp-0001wO-Km
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 07:50:57 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsOUr-0008RX-E1
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 07:47:53 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.6.3-rc2-1
References: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
In-Reply-To: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200402151256.41707.blaisorblade_spam@yahoo.it>
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
Date: Sun, 15 Feb 2004 12:56:41 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:18, venerd=EC 13 febbraio 2004, Jeff Dike ha scritto:
> This patch updates UML to 2.6.3-rc2.  This breaks with my usual practice =
of
> ignoring test patches.  However, when I updated my UML tree, I had
> forgotten that my stock Linus tree was up to 2.6.3-rc2.  I took this as a
> sign from a higher power that this was Meant To Be.

You seem too serious about your maintainer role! You have started writing=20
announces in The Way Linus Torvalds Does It (tm) :-) !

However, in my opinion what this higher power wants is that you post this=20
(with the needed changes) to Andrew Morton and that he includes it in 2.6.3!
And dropping the tty-uml-something piece.

> As well as catching up, there are some bug fixes and cleanups -
> 	modules should now work

About the R_386_* macros needed for this, they are defined twice in the pat=
ch=20
(archparam-i386.h and elf.h; they should be for now in elf.h, and in the=20
future in elf-i386.h since they are architecture-specific).

> 	worked around a process start time bug
> 	fixed a bug which caused ps to divide by zero
>
> The 2.6.3-rc2-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.3-rc2-1.bz2
>
> BK users can pull my 2.5 repository from
> 	http://www.user-mode-linux.org:5000/uml-2.5

About this, I have a doubt: do you upload only the releases there (as in 2.=
4's=20
cvs) or also the single changesets? You could do the second by tagging the =

releases (I don't use BitKeeper, but CVS allows it, and BitKeeper is by far=
=20
more sophisticated), so that users can use the stable version. Waiting for =

new features to get little bugfixes (the long long host_hz, for instance)=20
sometimes is tiring. And not knowing what is in the repository and what was=
=20
merged (sometimes mails are confusing).

Also, you could probably ask Andrew Morton to upgrade from your repository =
for=20
mm patches, as he does for various other BitKeeper trees (he said "just ask=
=20
for this special treatment"); you would only need to drop even from the sto=
ck=20
patch the /proc/mm support for nested UML's (which is not at all a bad thin=
g,=20
since it's not used heavily while nested UML would need testing).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
