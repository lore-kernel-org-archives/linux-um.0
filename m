Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUWVR-0004yK-5A
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 11:29:49 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AUWVQ-0004Kn-Kq
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 11:29:48 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] getting Arcangeli's patches (was: 2.4.23aa1)
References: <1071161579.6647.83.camel@etrs-pc02.ets.enterasys.com>
In-Reply-To: <1071161579.6647.83.camel@etrs-pc02.ets.enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200312112033.35073.blaisorblade_spam@yahoo.it>
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
Date: Thu, 11 Dec 2003 20:33:35 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 17:52, gioved=EC 11 dicembre 2003, D. Bahi ha scritto:
> does anybody here use or know about Andrea Arcangeli's patchset
> that includes UML?
>
> i'm wondering how upto/outof date it is - and if it incorporates
You can see that the version number is 2.4.20-5. (By looking at the complet=
e=20
filename of the skas patch).
A bit outdated, actually.
But the other patches could be interesting for Jeff to take into his tree..=
.=20
the names seem to mean that he fixed highmem support and a lot of other=20
things...

> both the uml-patch and the host-skas patch set in one....
>
I don't know... but the question is actually meaningless anyway. I.e. every=
=20
UML patch includes the SKAS patch, but it's useful for when you run a UML=20
inside another UML: this outer one will have the SKAS support for the inner=
=20
one. So you need the separate SKAS patch.
You need two separate kernel trees, or you won't be able to build a kernel.
For space consumption, you can get a vanilla tree(please clean it before do=
ing=20
this, or you'll copy built files and waste time and space for this) in one =

place(let's say /usr/src/linux), and do this:
cd /usr/src
cp -al linux linuxUm(note that the second folder MUST be on the same=20
partition; this command will create hardlink instead of copy, i.e. it will =

consume no space; anyway, patch will patch only one tree, since it creates =
a=20
new file, which is no more a hardlink).
cd linuxUm
<apply the UML patch>
cd ../linux
<apply the SKAS patch>
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
