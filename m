Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BibJl-0004fp-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 09:00:13 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BibJl-000486-6W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 09:00:13 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Unable to handle kernel paging request ...
References: <200407071945.30015.blaisorblade_spam@yahoo.it>
	<200407071929.46294.blaisorblade_spam@yahoo.it>
	<20040708033126.GA10586@bakunin.copyleft.de>
In-Reply-To: <20040708033126.GA10586@bakunin.copyleft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407081800.39890.blaisorblade_spam@yahoo.it>
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
Date: Thu, 8 Jul 2004 18:00:39 +0200
Content-Transfer-Encoding: quoted-printable
To: Michael Koehne <kraehe@copyleft.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 05:31, gioved=EC 8 luglio 2004, Michael Koehne ha scritto:
> Moin BlaisorBlade,

>   I'll stick to that combo for some more days (because of laziness ;)
>   and hope to be more patient writing down the kernel panic next time.
If you can, try also using, instead, a vanilla kernel. I'm highly suspiciou=
s=20
your crash is not SKAS-related.

If you get that panic with a kernel without any SKAS patch, then you should=
=20
report it onto the LKML (Linux Kernel Mailing List), hopefully with a stack=
=20
trace (yes, it's painful to write it down... - at least try providing the=20
names of the funcs involved - for instance, in this panic output (I've=20
received it a few minutes ago) There are only some interesting part (I mark=
ed=20
them with >):

> Jun 27 12:11:25 nimbus kernel: Unable to handle kernel paging request at
virtual address 00100104

Jun 27 12:11:25 nimbus kernel:  printing eip:
Jun 27 12:11:25 nimbus kernel: c011b31f
Jun 27 12:11:25 nimbus kernel: *pde =3D 00000000
Jun 27 12:11:25 nimbus kernel: Oops: 0002 [#1]
Jun 27 12:11:25 nimbus kernel: SMP=20
Jun 27 12:11:25 nimbus kernel: CPU:    0
Jun 27 12:11:25 nimbus kernel: EIP:    0060:[<c011b31f>]    Not tainted
Jun 27 12:11:25 nimbus kernel: EFLAGS: 00010202   (2.6.5040422)=20

> Jun 27 12:11:25 nimbus kernel: EIP is at mmput+0x23/0x68

Jun 27 12:11:25 nimbus kernel: eax: 00100100   ebx: ee2d3e00   ecx: ee2d3e34
edx: 00200200
Jun 27 12:11:25 nimbus kernel: esi: f5804c60   edi: 00000037   ebp: 00000000
esp: f085df80
Jun 27 12:11:25 nimbus kernel: ds: 007b   es: 007b   ss: 0068

> Jun 27 12:11:25 nimbus kernel: Process linux-2.6.5-a1- (pid: 8864,
threadinfo=3Df085c000 task=3Dc1b5f290)

Jun 27 12:11:25 nimbus kernel: Stack: ee2d3e00 c010d0d4 ee2d3e00 00000037
00000044 00000037 f085c000 f085c000=20
Jun 27 12:11:25 nimbus kernel:        f5804c60 f636f080 a696b5e8 0000001c
c0149aa4 00000044 bfc00000 00000001=20
Jun 27 12:11:25 nimbus kernel:        c0108573 00000037 000022a2 00000000
00000044 00000037 a696b65c 0000001a=20

> And finally, these lines are VERY important (I don't care the <c010...>=20
part, just the "sys_ptrace"-"sys_write"-"syscall_call" part.

Jun 27 12:11:25 nimbus kernel: Call Trace:
Jun 27 12:11:25 nimbus kernel:  [<c010d0d4>] sys_ptrace+0x754/0x7d0
Jun 27 12:11:25 nimbus kernel:  [<c0149aa4>] sys_write+0x44/0x4c
Jun 27 12:11:25 nimbus kernel:  [<c0108573>] syscall_call+0x7/0xb

Jun 27 12:11:25 nimbus kernel:=20
Jun 27 12:11:25 nimbus kernel: Code: 89 50 04 89 02 c7 43 34 00 01 10 00 c7
41 04 00 02 20 00 ff

So you could write down, for that panic:
----
Unable to handle kernel paging request at
virtual address???

EIP is at mmput

Call Trace:

sys_ptrace
sys_write
syscall_call
----
The other part are harder to decode and much less useful, in this situation=
=20
(they can be used, but it's difficult).
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
