Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmXOG-0008H8-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 05:37:08 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BmXOF-0005fZ-T0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 05:37:08 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407191404.34410.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Host oops caused by SKAS?
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
Date: Mon, 19 Jul 2004 14:04:34 +0200
Content-Transfer-Encoding: quoted-printable
To: "C. Roscik" <cr@d-range.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 20:20, mercoled=EC 7 luglio 2004, C. Roscik ha scritto:
> Hello Blaisorblade,
>
> i experienced an Host oops and for me it looks like skas is involved.
> Maybe you can read something out of it, I can't =3D)

Yes, I confirm that you. It should be useful enough.

> Host Kernel =3D Vanilla 2.6.5 + host-skas3-2.6.3-v1.patch (from your site)
> Guest Kernel was =3D Vanilla 2.6.5 + uml-patch-2.6.4-1 + 2.6.5-uml1.fix2

> If there are any other infos that could be usefull let me know.

Yes: has the host any special configuration (SMP, HIGHMEM...)? I read that =
SMP=20
is enabled in the Oops (am I wrong?). I'm for now forwarding this to the=20
list, I've not yet had time to look at it.

Bye

> Jun 27 12:11:25 nimbus kernel: Unable to handle kernel paging request at
> virtual address 00100104
> Jun 27 12:11:25 nimbus kernel:  printing eip:
> Jun 27 12:11:25 nimbus kernel: c011b31f
> Jun 27 12:11:25 nimbus kernel: *pde =3D 00000000
> Jun 27 12:11:25 nimbus kernel: Oops: 0002 [#1]
> Jun 27 12:11:25 nimbus kernel: SMP
> Jun 27 12:11:25 nimbus kernel: CPU:    0
> Jun 27 12:11:25 nimbus kernel: EIP:    0060:[<c011b31f>]    Not tainted
> Jun 27 12:11:25 nimbus kernel: EFLAGS: 00010202   (2.6.5040422)
> Jun 27 12:11:25 nimbus kernel: EIP is at mmput+0x23/0x68
> Jun 27 12:11:25 nimbus kernel: eax: 00100100   ebx: ee2d3e00   ecx:
> ee2d3e34 edx: 00200200
> Jun 27 12:11:25 nimbus kernel: esi: f5804c60   edi: 00000037   ebp:
> 00000000 esp: f085df80
> Jun 27 12:11:25 nimbus kernel: ds: 007b   es: 007b   ss: 0068
> Jun 27 12:11:25 nimbus kernel: Process linux-2.6.5-a1- (pid: 8864,
> threadinfo=3Df085c000 task=3Dc1b5f290)
> Jun 27 12:11:25 nimbus kernel: Stack: ee2d3e00 c010d0d4 ee2d3e00 00000037
> 00000044 00000037 f085c000 f085c000
> Jun 27 12:11:25 nimbus kernel:        f5804c60 f636f080 a696b5e8 0000001c
> c0149aa4 00000044 bfc00000 00000001
> Jun 27 12:11:25 nimbus kernel:        c0108573 00000037 000022a2 00000000
> 00000044 00000037 a696b65c 0000001a
> Jun 27 12:11:25 nimbus kernel: Call Trace:
> Jun 27 12:11:25 nimbus kernel:  [<c010d0d4>] sys_ptrace+0x754/0x7d0
> Jun 27 12:11:25 nimbus kernel:  [<c0149aa4>] sys_write+0x44/0x4c
> Jun 27 12:11:25 nimbus kernel:  [<c0108573>] syscall_call+0x7/0xb
> Jun 27 12:11:25 nimbus kernel:
> Jun 27 12:11:25 nimbus kernel: Code: 89 50 04 89 02 c7 43 34 00 01 10 00 =
c7
> 41 04 00 02 20 00 ff

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
