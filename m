Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtzJ4-0007nx-Gj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 18:22:50 -0800
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtzJ1-000642-Qd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 18:22:50 -0800
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id VAA11304
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Jan 2005 21:22:43 -0500 (EST)
Message-ID: <41F85058.8050106@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <200501262310.49814.blaisorblade@yahoo.it>
In-Reply-To: <200501262310.49814.blaisorblade@yahoo.it>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1925E2B802F41D5583A8A229"
Subject: [uml-devel] Re: [uml-user] [POLL] Putting UML/2.4 into "fixes-only"
	mode
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
Date: Wed, 26 Jan 2005 21:22:16 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1925E2B802F41D5583A8A229
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I would like a 2.4 that is stable. with a working hostfs.
(that i can run valgrind against - heh, not umls fault here.)
Also, the uml web site needs to be authoritative. building
the above should not require patching from additional
sources announced on the list.

That said, 2.4 and 2.6 are both 'stable' kernel branches
that have had quite a bit of UML development in them. So,
if it helps future maintaining of both 2.4 and 2.6, at
least until 2.7 appears, then do what you need to do.
please don't abandon 2.4 until 2.7 is well under way.

Maybe you could break up the 2.4 patches into 'stable'
'testing' and 'experimental' ?

db

Blaisorblade wrote:

>Jeff, I've seen the beginning of your work on back-porting all the patches 
>from 2.6 to 2.4...
>
>It's a huge work, but what is more important, it could obviously hurt 
>stability...
>
>So, I'd suggest to follow this policy to choose the work to merge:
>
>- reduce *a lot* what is going to be merged... no new features, no code 
>cleanups (especially NOT the Makefiles cleanups)...
>
>- concentrate on stability... and on backing out the hostfs rewrite.
>  
>

-- 
db


--------------enig1925E2B802F41D5583A8A229
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFB+FBc3XQ4zakZ3z4RAqogAJ9VXf2+G6eJgvcwacBK6dD1iEny2QCcCoRY
wf3IlElTexJzMe/2goViS4o=
=ZZnd
-----END PGP SIGNATURE-----

--------------enig1925E2B802F41D5583A8A229--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
