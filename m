Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-22-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-22-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 15 Feb 2021 02:00:35 +0900
Message-ID: <CAK7LNAQDcfqSCsCeG9+ytrJNfD5mS8OLS2uZS8WRBuTHRL1qRg@mail.gmail.com>
Subject: Re: [PATCH 21/27] sparc: remove wrong comment from
 arch/sparc/include/asm/Kbuild
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc: "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-alpha@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 28, 2021 at 9:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> These are NOT exported to userspace.
>
> The headers listed in arch/sparc/include/uapi/asm/Kbuild are exported.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to linux-kbuild/fixes.


> ---
>
>  arch/sparc/include/asm/Kbuild | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index 3688fdae50e4..aec20406145e 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -# User exported sparc header files
> -
>  generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
>  generated-y += syscall_table_c32.h
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

