Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 May 2018 09:37:28 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] um: remove unused vdso-syms.lds
Message-ID: <20180514073728.GA19463@gmail.com>
References: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This file contains symbol values, and was originally linked into
> vmlinux, but I have no idea what it was actually used for.
> 
> Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
> not even linked.  Now it is completely orphan, and no problem has
> been reported.  It is a proof that this file was not needed in the
> first place.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/x86/um/vdso/.gitignore |  1 -
>  arch/x86/um/vdso/Makefile   | 16 ----------------
>  2 files changed, 17 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

