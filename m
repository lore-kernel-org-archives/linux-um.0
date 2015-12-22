Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450820692-10557-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5679CE80.4030006@nod.at>
Date: Tue, 22 Dec 2015 23:28:16 +0100
MIME-Version: 1.0
In-Reply-To: <1450820692-10557-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Fix build error and kconfig for i386
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 22.12.2015 um 22:44 schrieb Micka=C3=ABl Sala=C3=BCn:
> Fix build error by selecting COREDUMP when X86_32 is selected:
>=20
> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
> (.text+0x3e62): undefined reference to `dump_emit'
> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
> (.text+0x3eef): undefined reference to `dump_emit'
>=20
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/um/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index ed56a1c4ae73..bb7cd8b38043 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -26,6 +26,7 @@ config X86_32
>  	select CLONE_BACKWARDS
>  	select OLD_SIGSUSPEND3
>  	select OLD_SIGACTION
> +	select COREDUMP


Do you know since when this is broken?

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

