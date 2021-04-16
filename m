Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXHhq-0096jD-Uh
 for linux-um@lists.infradead.org; Fri, 16 Apr 2021 06:11:56 +0000
Subject: Re: [PATCH v2] uml: fix W=1 missing-include-dirs warnings
References: <20210415171352.27398-1-rdunlap@infradead.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e3a93e3e-84ba-7274-3476-d63ad4fbcca9@cambridgegreys.com>
Date: Fri, 16 Apr 2021 07:11:43 +0100
MIME-Version: 1.0
In-Reply-To: <20210415171352.27398-1-rdunlap@infradead.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org

On 15/04/2021 18:13, Randy Dunlap wrote:
> Currently when using "W=1" with UML builds, there are over 700 warnings
> like so:
>
>    CC      arch/um/drivers/stderr_console.o
> cc1: warning: ./arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
>
> but arch/um/ does not have include/uapi/ at all, so add that
> subdir and put one Kbuild file into it (since git does not track
> empty subdirs).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> ---
> v2: use Option 4 from v1: add arch/um/include/uapi so that 'make' is
>      placated -- and just like all other arch's have.
>
>   arch/um/include/uapi/asm/Kbuild |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/um/include/uapi/asm/Kbuild b/arch/um/include/uapi/asm/Kbuild
> new file mode 100644
> index 000000000000..f66554cd5c45
> --- /dev/null
> +++ b/arch/um/include/uapi/asm/Kbuild
> @@ -0,0 +1 @@
> +# SPDX-License-Identifier: GPL-2.0
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>
+1

I will forward it to openwrt-dev. Their build process adds uapi to uml, 
so if we are going to change this, it will be nice to give them a heads-up.

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

