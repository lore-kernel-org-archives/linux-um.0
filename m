Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL50m-0006fw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 10:19:08 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AL50l-0005Bt-W8
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 10:19:08 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4 host
References: <Pine.GSO.4.58.0311112056030.5253@altair.dur.ac.uk>
In-Reply-To: <Pine.GSO.4.58.0311112056030.5253@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311151922.23540.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 15 Nov 2003 19:22:23 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:01, marted=EC 11 novembre 2003, M A Young ha scritto:
> jdike wrote:
> >> If you have little  time, I can post this
> >> together with a patch to the spec file which is again  out of
> >> date(some files are not listed).
> >
> >Send me a patch to the spec file, please.

>
> It is a fairly trival fix, eg. see the attached patch.
I've sent it to him privately already, and using wildcards, so that it does=
n't=20
need to be updated so frequently:

%attr(755,root,root)                   %{_bindir}/*
And if you wonder, the wildcards expands relatively to the buildroot, i.e. =

files installed by make install... I tested it and it was flawless.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target_________________=
______________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
