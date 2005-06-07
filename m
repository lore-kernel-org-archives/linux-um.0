Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dfk3E-0001d4-63	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 12:47:52 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user81758)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dfk3B-0003SM-7f	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 12:47:51 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506071811.52440.blaisorblade@yahoo.it>
	<87acm25e9j.fsf@amaterasu.srvr.nix>
	<200506071844.58916.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200506071844.58916.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Tue, 7 Jun 2005 18:44:41 +0200")
Message-ID: <871x7e54pv.fsf@amaterasu.srvr.nix>
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
Date: Tue, 07 Jun 2005 20:47:40 +0100
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 7 Jun 2005, blaisorblade@yahoo.it suggested tentatively:
> On Tuesday 07 June 2005 18:21, Nix wrote:
>> OK, so it's a -static TT build that's failing?
> Exactly.

Built, with a randomly selected .config (that is, a .config I use for
other things, not a .config with the values set at random!)

Not quite built without problems. Can you guess the cause of this?

        gcc -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc -o =
.tmp_vmlinux1 -Wl,-T,arch/um/kernel/vmlinux.lds   init/built-in.o -Wl,--sta=
art-group  usr/built-in.o  arch/um/kernel/built-in.o  arch/um/drivers/built=
-in.o  arch/um/os-Linux/built-in.o  arch/um/sys-i386/built-in.o  arch/i386/=
crypto/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/bui=
lt-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  lib/built-in.o =
 drivers/built-in.o  sound/built-in.o  net/built-in.o -Wl,--end-group -luti=
l  ; rm -f linux
/usr/bin/ld: cannot find -lutil

Guess where the static libutil.a is. That's right, /usr/lib. Are
we searching it in that linker script? No :(

diff -durN linux-2.6.11.10-bs6-orig/arch/um/kernel/uml.lds.S linux-2.6.11.1=
0-bs6/arch/um/kernel/uml.lds.S
--- linux-2.6.11.10-bs6-orig/arch/um/kernel/uml.lds.S	2005-06-07 20:23:58.0=
00000000 +0100
+++ linux-2.6.11.10-bs6/arch/um/kernel/uml.lds.S	2005-06-07 20:41:45.000000=
000 +0100
@@ -4,6 +4,7 @@
 OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
 jiffies =3D jiffies_64;
+SEARCH_DIR("/usr/lib"); SEARCH_DIR("/lib");
=20
 SECTIONS
 {

With that applied, it builds...

... and segfaults almost at once on invocation:

execve("./vmlinux", ["./vmlinux"], [/* 49 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"hades", ...}) =3D 0
brk(0)                                  =3D 0xa0343000
brk(0xa0343834)                         =3D 0xa0343834
set_thread_area({entry_number:-1 -> 6, base_addr:0xa034381c, limit:1048575,=
 seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_prese=
nt:0, useable:1}) =3D 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

#0  0xa01a16a7 in ptmalloc_init ()
#1  0x00000000 in ?? ()
#2  0x00000000 in ?? ()
#3  0x00000000 in ?? ()
#4  0x00000000 in ?? ()
#5  0x00000000 in ?? ()
#6  0x00000000 in ?? ()
#7  0x00000000 in ?? ()
#8  0x00000000 in ?? ()
#9  0x00000000 in ?? ()
#10 0x00000000 in ?? ()
#11 0x00000000 in ?? ()
#12 0xbffff2b2 in ?? ()
#13 0xa0343000 in ?? ()
#14 0x0000000c in ?? ()
#15 0xbffff444 in ?? ()
#16 0x0000000c in ?? ()
#17 0xbffff1a0 in ?? ()
#18 0xa01a19a7 in malloc_hook_ini ()
#19 0xa0213f3f in xdigits.0 ()
#20 0xa01a0e4a in malloc ()
#21 0x0000000c in ?? ()
#22 0xa01ccb7c in _dl_init_paths ()
#23 0xa01aa42c in _dl_non_dynamic_init ()
#24 0x000fffff in ?? ()
#25 0xbffff44c in ?? ()
#26 0xbffff444 in ?? ()
#27 0x00000001 in ?? ()
#28 0xbffff2b2 in ?? ()
#29 0xa01aa76b in init ()
#30 0x0000037f in ?? ()
#31 0x00000003 in ?? ()
#32 0xbffff2b2 in ?? ()
#33 0xa018dbc7 in __pthread_initialize_minimal ()
#34 0x00000000 in ?? ()
#35 0x0002060b in ?? ()
#36 0x00000003 in ?? ()
#37 0xa018d6bd in __libc_start_main ()
#38 0x00000000 in ?? ()

Looks like a thread initialization problem to *me*. And there be very
serious and nasty snarling dragons with sharp pointy carborundum teeth
:(

(this box, btw, is an AMD Athlon 4: it *does* have CMOV support. Not
that that could plausibly be the problem here.)

>> Patch mis-rolled, I guess: arch/um/scripts/Makefile.rules is missing,
>> yet included from multiple places:
> Not only that, dear boy, not only that... I now looked=20
>=20
> combinediff: hunk-splitting is required in this case, but is not yet impl=
emented
> combinediff: use the -U option to work around this

Whoops!

I guess not many people have tried to build -bs6, then: I doubt that would =
work
terribly well in skas mode, either ;)

> Seems like I'll have to resort to something bad... which is attached, i.e=
.=20
> black magic (using -U from time to time).

Black magic during debugging makes me nervous, so...

> Alternatively, use patch1.bz2 and patch2.bz2, which have normal context (=
the=20
> final patch has been generated by merging them).

... I used these, which applied fine.

>> [fixed one bug in a local administrative script at 04:00 this morning...
>>  insomnia sucks, hay fever sucks, temperatures above 15C suck...]
> I share with you insomnia and hay fever (if I do the right guess). For=20

`Seasonal allergic rhinitis', i.e., plants trying to have sex with my
nose over my violent protests.

> temperatures above 15C, I don't: I live in Sicily, so here we're at about=
=20

I guessed that. Merely .it is a preetty big clue. Myself, I've carefully
steered clear of southern Europe and points south in the summer. April
Rome temperatures are about the most I'm comfortable with.

> 25=B0-30=B0 C, and it'll go up to 40=B0C...

Well, it's done that in the south-east of England, too, but I don't have
to like it, and it's `exceptional' (i.e. `has happened almost every year
for the last decade' :( )

--=20
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotp=
ut
a projector? How fast can you ride your desk chair down the office luge tra=
ck?
If you want to score the big prize, get to know the little guy. =20
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
