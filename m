Return-Path: <p.giarrusso@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201006141149.24647.toralf.foerster@gmx.de>
References: <201005271944.09541.toralf.foerster@gmx.de> <201005311555.56791.toralf.foerster@gmx.de> 
	<20100531141058.GB4915@aftab> <201006141149.24647.toralf.foerster@gmx.de>
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Mon, 14 Jun 2010 12:26:11 +0200
Message-ID: <AANLkTilHgepfQVqz3ZNiOXFYEQGOZDzVKk8JZnU_5IJs@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] x86, hweight: Fix UML boot crash
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Borislav Petkov <borislav.petkov@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/6/14 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
>
> Borislav Petkov wrote at 16:10:58
>> Did you do 'make mrproper' before rebuilding UML with it?
>
> Today I started with a clean git tree (cloned Linus tree) and got this :
>
> foerste@n22 ~ $ start_uml.sh

Can you enable frame pointers to get an accurate stack trace? x86 can
be accurate without, but I don't think this was ever implemented for
UML.
Because I'm not sure if below cfq_close_cooperator is being called
again, or if it's just garbage (as I guess). Anyway, it's still likely
that the crash is on hweight32.

Also, it'd be interesting to diff your configuration with the one used
by people the patch works for. Say,
$ grep HWEIGHT .config
(if there are any CFLAGS set in ARcH_HWEIGHT_CFLAGS, that would be a
problem as far as I see).

> EIP: 0073:[<081c4fcb>] CPU: 0 Not tainted ESP: 007b:08300b40 EFLAGS: 0001=
0297
> =C2=A0 =C2=A0Not tainted
> EAX: 00000000 EBX: 190d2000 ECX: ffff8aea EDX: 00000000
> ESI: 191f4930 EDI: 191ef900 EBP: 191f4930 DS: 007b ES: 007b
> 08300794: =C2=A0[<0805e65f>] segv_handler+0x3f/0x60
> 083007a4: =C2=A0[<081c4fcb>] cfq_close_cooperator+0x4b/0x180
> 083007b0: =C2=A0[<0806eec5>] sig_handler_common+0x55/0xa0
> 083007f0: =C2=A0[<081c4fcb>] cfq_close_cooperator+0x4b/0x180
> 08300828: =C2=A0[<0806f063>] sig_handler+0x23/0x40
> 08300830: =C2=A0[<0806f2bd>] handle_signal+0x5d/0xa0
> 08300850: =C2=A0[<080715f7>] hard_handler+0x17/0x20
> 0830089c: =C2=A0[<081c4fcb>] cfq_close_cooperator+0x4b/0x180
> 08300a4c: =C2=A0[<0807a3eb>] T.696+0x9b/0xc0
> 08300a74: =C2=A0[<08079425>] enqueue_task+0x45/0x60
> 08300a94: =C2=A0[<0807945f>] activate_task+0x1f/0x30
> 08300aa0: =C2=A0[<080794d8>] try_to_wake_up+0x68/0xa0
> 08300acc: =C2=A0[<0809369f>] autoremove_wake_function+0x2f/0x60
> 08300ae8: =C2=A0[<0807754f>] __wake_up_common+0x4f/0x80
> 08300b18: =C2=A0[<08077837>] __wake_up+0x47/0x60
> 08300b3c: =C2=A0[<081c4fc6>] cfq_close_cooperator+0x46/0x180
> 08300b58: =C2=A0[<081c5440>] cfq_completed_request+0x2a0/0x560
> 08300b90: =C2=A0[<081b7fce>] elv_completed_request+0x7e/0xf0
> 08300ba8: =C2=A0[<081b98f6>] __blk_put_request+0x36/0xf0
> 08300bc0: =C2=A0[<081b9b26>] blk_finish_request+0x176/0x1d0
> 08300be0: =C2=A0[<081b9ea1>] blk_end_bidi_request+0x41/0x60
> 08300bf4: =C2=A0[<08068e8d>] ubd_intr+0x2d/0xf0
> 08300c14: =C2=A0[<080a6b32>] handle_IRQ_event+0x32/0xc0
> 08300c34: =C2=A0[<080a6c1b>] __do_IRQ+0x5b/0xb0
> 08300c50: =C2=A0[<0805b364>] do_IRQ+0x24/0x40
> 08300c5c: =C2=A0[<0805b59b>] sigio_handler+0x5b/0x80
> 08300c70: =C2=A0[<0806eec5>] sig_handler_common+0x55/0xa0
> 08300c80: =C2=A0[<0806efb5>] real_alarm_handler+0x35/0x40
> 08300cbc: =C2=A0[<080739f0>] __delay+0x20/0x30
> 08300ce8: =C2=A0[<0806f063>] sig_handler+0x23/0x40
> 08300cf0: =C2=A0[<0806f2bd>] handle_signal+0x5d/0xa0
> 08300d10: =C2=A0[<080715f7>] hard_handler+0x17/0x20


--=20
Paolo Giarrusso - Ph.D. Student
http://www.informatik.uni-marburg.de/~pgiarrusso/

