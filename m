Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Apr 2018 14:29:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH AUTOSEL for 3.18 059/101] x86/um: thin archives build
 fix
Message-ID: <20180409142911.34fe1065@roar.ozlabs.ibm.com>
In-Reply-To: <20180409004042.164920-9-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
        <20180409004042.164920-9-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 9 Apr 2018 00:41:22 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> 
> [ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]
> 
> The linker does not like vdso-syms.lds in input archive files.
> Make it an extra-y instead.

I wouldn't say these should be needed on kernels without thin
archives build.

It shouldn't hurt, but no point risking stable breakage.

Thanks,
Nick

