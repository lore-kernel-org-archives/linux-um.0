MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201106291742.24137.richard@nod.at>
References: <1309212931-19772-1-git-send-email-richard@nod.at>
	<BANLkTikauFJtuCo5E3=tb_=cwVS3sF35zw@mail.gmail.com>
	<201106291742.24137.richard@nod.at>
Date: Wed, 29 Jun 2011 18:42:43 +0200
Message-ID: <BANLkTikLEPgtK+Z6jD1r18TySkzNbLQJjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] um: Fix _FORTIFY_SOURCE=2 support for kernel modules
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: Vitaliy Ivanov <vitalivanov@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Florian Fainelli <florian@openwrt.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 29, 2011 at 17:42, Richard Weinberger <richard@nod.at> wrote:
> Am Mittwoch 29 Juni 2011, 17:37:54 schrieb Vitaliy Ivanov:
>> On Tue, Jun 28, 2011 at 1:15 AM, Richard Weinberger <richard@nod.at> wro=
te:
>> > When UML is compiled with _FORTIFY_SOURCE we have to
>> > export all _chk() functions which are used in modules.
>> > For now it's only the case for __sprintf_chk().
>> >
>> > Tested-by: Florian Fainelli <florian@openwrt.org>
>> > Reported-by: Florian Fainelli <florian@openwrt.org>
>> > Signed-off-by: Richard Weinberger <richard@nod.at>
>> > ---
>> > =C2=A0arch/um/os-Linux/user_syms.c | =C2=A0 =C2=A05 +++++
>> > =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms=
.c
>> > index 05f5ea8..45ffe46 100644
>> > --- a/arch/um/os-Linux/user_syms.c
>> > +++ b/arch/um/os-Linux/user_syms.c
>> > @@ -113,3 +113,8 @@ EXPORT_SYMBOL(__stack_smash_handler);
>> >
>> > =C2=A0extern long __guard __attribute__((weak));
>> > =C2=A0EXPORT_SYMBOL(__guard);
>> > +
>> > +#ifdef _FORTIFY_SOURCE
>> > +extern int __sprintf_chk(char *str, int flag, size_t strlen, const ch=
ar
>> > *format); +EXPORT_SYMBOL(__sprintf_chk);
>> > +#endif
>> > --
>>
>> Can you please clarify why it's needed? I use FORTIFY_SOURCES on
>> Linus' tree UML on Ubuntu w/ no problems and w/o this patch...
>
> The problem appears only when a UML kernel module is using sprintf().
> E.g: CONFIG_UML_WATCHDOG.
> Then loading the module will fail because of the missing symbol __sprintf=
_chk().

What about changing harddog_user.c to not use sprintf(), but snprintf()?

Besides, the code does look fishy to me:

    char pid_buf[sizeof("nnnnn\0")];
    sprintf(pid_buf, "%d", os_getpid());

os_getpid() returns int:

    int os_getpid(void)
    {
            return syscall(__NR_getpid);
    }

but sys_getpid() returns long.

So we truncate a (possibly 64-bit number) to 32-bit, and format it
in a buffer that has space for 5 chars only...

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

