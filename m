Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yavr-0000rp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 10:45:07 -0700
Received: from smtp012.mail.yahoo.com ([216.136.173.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yavr-0004Qp-6l
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 10:45:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4 host
References: <3F59DC82.7070900@bezeqint.net> <200309081647.h88Glrjh030128@ccure.karaya.com> <Pine.GSO.4.53.0309122100390.4368@altair.dur.ac.uk>
In-Reply-To: <Pine.GSO.4.53.0309122100390.4368@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200309141946.05977.blaisorblade_spam@yahoo.it>
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
Date: Sun, 14 Sep 2003 19:46:05 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:03, venerd=EC 12 settembre 2003, M A Young ha scritto:
> On Mon, 8 Sep 2003, Jeff Dike wrote:
> > Try it with the latest patch.  It should be fixed - I applied a differe=
nt
> > fix from the one suggested by Michael Young.
>
> My limited testing suggest the problem is indeed fixed in 2.4.22-3um (and
> presumably in -2um as well though I haven't tried it).
I could see the bug with 2.6.0-test4/test5, and for me, too it was solved=20
using 2.4.22-3um. So that's ok.
About 2.6, there is a little patch to implement in the uml_utilities, since=
=20
insmod tun doesn't work any more with the new module-init-tools. That must =

change to modprobe tun. That is, replace "insmod" by "modprobe"(including=20
quotes!) all over uml_net/ethertap.c and uml_net/tuntap.c. If you have litt=
le=20
time, I can post this together with a patch to the spec file which is again=
=20
out of date(some files are not listed).
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
