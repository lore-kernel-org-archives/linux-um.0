Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1272844700-32496-1-git-send-email-nico@openwrt.org>
References: <1272844700-32496-1-git-send-email-nico@openwrt.org>
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Mon, 17 May 2010 16:42:23 +0200
Message-ID: <AANLkTiks4xC4ecImFzaFBpLdBp7l7iUO941fYyCetxTA@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] UML: x86_64: fix memcpy export
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Thill <nicolas.thill@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nicolas Thill <nico@openwrt.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Shouldn't this thing be in arch/um/sys-i386/ksyms.c, instead of having #ifndef?

On Mon, May 3, 2010 at 01:58, Nicolas Thill <nicolas.thill@gmail.com> wrote:
> ./arch/um/sys-x86_64/ksyms.c exports memcpy or __memcpy depending on the gcc
> version, use the same logic in ./arch/um/os-Linux/user_syms.c
>
> Signed-off-by: Nicolas Thill <nico@openwrt.org>
> ---
>  arch/um/os-Linux/user_syms.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
> index 89b48a1..e3a12dd 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -23,7 +23,8 @@ extern int printf(const char *, ...);
>  EXPORT_SYMBOL(strstr);
>  #endif
>
> -#ifndef __x86_64__
> +#if !defined(__x86_64) || \
> +       (__GNUC__ == 4 && __GNUC_MINOR__ < 3) || (__GNUC__ < 4)
>  extern void *memcpy(void *, const void *, size_t);
>  EXPORT_SYMBOL(memcpy);
>  #endif
> --
> 1.6.0.4
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-- 
Paolo Giarrusso
