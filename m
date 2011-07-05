MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201107051331.15504.richard@nod.at>
References: <1309821341.4527.5.camel@vitaliy-Vostro-1400>
	<201107051128.25262.richard@nod.at>
	<CAGTPOqcAETWHG3DEOwDZkMG8_qd-opf90psCi=+U+tYcGV=7=A@mail.gmail.com>
	<201107051331.15504.richard@nod.at>
Date: Tue, 5 Jul 2011 13:38:05 +0200
Message-ID: <CAMuHMdWWPiFTwQ+0Et8eZZbCy-DtzRMeK=-rFY_NfEWWjYrZ2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] uml: cow_user.c warning corrections
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: Vitaliy Ivanov <vitalivanov@gmail.com>, Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Jul 5, 2011 at 13:31, Richard Weinberger <richard@nod.at> wrote:
> Am Dienstag 05 Juli 2011, 13:10:34 schrieb Vitaliy Ivanov:
>> On Tue, Jul 5, 2011 at 12:28 PM, Richard Weinberger <richard@nod.at> wro=
te:
>> > Am Dienstag 05 Juli 2011, 01:15:41 schrieb Vitaliy Ivanov:
>> >> From 6201d3e862fca8670b206338dc90303ea0acc77d Mon Sep 17 00:00:00 200=
1
>> >> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>> >> Date: Tue, 5 Jul 2011 01:57:51 +0300
>> >> Subject: [PATCH 1/4] uml: cow_user.c warning corrections
>> >> MIME-Version: 1.0
>> >> Content-Type: text/plain; charset=3DUTF-8
>> >> Content-Transfer-Encoding: 8bit
>> >>
>> >> arch/um/drivers/cow_user.c: In function =E2=80=98absolutize=E2=80=99:
>> >> arch/um/drivers/cow_user.c:189:7: warning: ignoring return value of
>> >> =E2=80=98chdir=E2=80=99, declared with attribute warn_unused_result
>> >
>> > What compiler flags are you using?
>> > Using the default settings this warning does not show up.
>> > Most of the "ignoring return value" are totally useless.
>>
>> chdir is defined with warn_unused_result attribute and my gcc on
>> Ubuntu 11.04 issues warnings.
>> I don't use any additional flags on compiling UML.
>
> Ah, because of -D_FORTIFY_SOURCE=3D2, right?
> Then your patches makes sense.

I also saw it, with gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5).
I never used FORTIFY_SOURCE.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

