Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201106291742.24137.richard@nod.at>
References: <1309212931-19772-1-git-send-email-richard@nod.at>
	<BANLkTikauFJtuCo5E3=tb_=cwVS3sF35zw@mail.gmail.com>
	<201106291742.24137.richard@nod.at>
Date: Wed, 29 Jun 2011 19:33:34 +0300
Message-ID: <BANLkTimg1djQt+wVvvZVL_DPMYhabD08_A@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/4] um: Fix _FORTIFY_SOURCE=2 support for kernel modules
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 29, 2011 at 6:42 PM, Richard Weinberger <richard@nod.at> wr=
ote:
> Am Mittwoch 29 Juni 2011, 17:37:54 schrieb Vitaliy Ivanov:
>> On Tue, Jun 28, 2011 at 1:15 AM, Richard Weinberger <richard@nod.at>=
 wrote:
>> > When UML is compiled with _FORTIFY_SOURCE we have to
>> > export all _chk() functions which are used in modules.
>> > For now it's only the case for __sprintf_chk().
>> >
>> > Tested-by: Florian Fainelli <florian@openwrt.org>
>> > Reported-by: Florian Fainelli <florian@openwrt.org>
>> > Signed-off-by: Richard Weinberger <richard@nod.at>
>> > ---
>> > =A0arch/um/os-Linux/user_syms.c | =A0 =A05 +++++
>> > =A01 files changed, 5 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_=
syms.c
>> > index 05f5ea8..45ffe46 100644
>> > --- a/arch/um/os-Linux/user_syms.c
>> > +++ b/arch/um/os-Linux/user_syms.c
>> > @@ -113,3 +113,8 @@ EXPORT_SYMBOL(__stack_smash_handler);
>> >
>> > =A0extern long __guard __attribute__((weak));
>> > =A0EXPORT_SYMBOL(__guard);
>> > +
>> > +#ifdef _FORTIFY_SOURCE
>> > +extern int __sprintf_chk(char *str, int flag, size_t strlen, cons=
t char
>> > *format); +EXPORT_SYMBOL(__sprintf_chk);
>> > +#endif
>> > --
>>
>> Can you please clarify why it's needed? I use FORTIFY_SOURCES on
>> Linus' tree UML on Ubuntu w/ no problems and w/o this patch...
>
> The problem appears only when a UML kernel module is using sprintf().
> E.g: CONFIG_UML_WATCHDOG.
> Then loading the module will fail because of the missing symbol __spr=
intf_chk().

Thanks.

Acked-by: Vitaliy Ivanov <vitalivanov@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

