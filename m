Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZxE1-0008N7-3h
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:02:17 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZxE0-00032Y-Ir
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:02:16 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML patches against vanilla 2.6.0
References: <200312261905.48277.blaisorblade_spam@yahoo.it> <20031226182737.GK2378@erdos.home>
In-Reply-To: <20031226182737.GK2378@erdos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312261956.13626.blaisorblade_spam@yahoo.it>
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
Date: Fri, 26 Dec 2003 19:56:13 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:27, venerd=EC 26 dicembre 2003, Cameron Patrick ha scritto:
> On Fri, Dec 26, 2003 at 07:05:48PM +0100, BlaisorBlade wrote:
> | Go here:
> |
> | http://web.tiscali.it/no-redirect-tiscali/blaisorblade/index.html
>
> Which says:
>
> 	The only problematic patch is A-04-MM-compile-fix.patch, but
> 	maybe i386 can live even with it (I don't remember if I got a
> 	successful compilation with it applied). However, I think it's
> 	not at all safe even if it compiles.
>
> and in the README:
>
> 	but I think you'd better avoid doing this or do a complete
> 	backup, since you'll need it...).

> Eeek!  I just upgraded my home desktop to a 2.6.0 kernel with that patch
> applied (actually as part of Jeff's 2.6.0-test9 patch) and so far it
> seems to be working.
Are you sure? If you compile a stock 2.6.0 with Jeff's 2.6.0-test9 patch an=
d=20
try to compile an i386 kernel, you'll get soon errors about=20
do_mmap_pgoff(except if you applied a host-skas to your 2.6 tree).

> Looking at the patch, it seems innocuous enough -
> why should it be unsafe on an i386 kernel?

I don't know actually, but it doesn't seem innocuous.

Instead, FIXADDR_USER_START is replaced by FIXADDR_START(+ some syntactical=
=20
changes that do not hurt). And they have a different meaning(see=20
include/asm-i386/fixmap.h).

Since I'm not a VM hacker, and I don't understand the change, I just say th=
at=20
that shouldn't be used, for prudence's sake. That mention about backup is=20
maybe a bit exaggerated, but it's a form of "no warranty" disclaimer.

*NOTE*: the combo patches from Ingo Molnar contain this, too(I don't know i=
f=20
he noticed this change at all), and he probably used this without problem. =
So=20
I may be wrong at all.

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
