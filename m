Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7SG-008q39-0t
 for linux-um@lists.infradead.org; Thu, 15 Apr 2021 19:15:10 +0000
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 13FJEogT017062
 for <linux-um@lists.infradead.org>; Fri, 16 Apr 2021 04:14:51 +0900
Received: by mail-pf1-f180.google.com with SMTP id a12so16706054pfc.7
 for <linux-um@lists.infradead.org>; Thu, 15 Apr 2021 12:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210415171352.27398-1-rdunlap@infradead.org>
In-Reply-To: <20210415171352.27398-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 16 Apr 2021 04:14:13 +0900
Message-ID: <CAK7LNASRLgRTZMwzbwnrYA96hLDpzWm8JVBMYQSHMNasXCHtdQ@mail.gmail.com>
Subject: Re: [PATCH v2] uml: fix W=1 missing-include-dirs warnings
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Fri, Apr 16, 2021 at 2:14 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Currently when using "W=1" with UML builds, there are over 700 warnings
> like so:
>
>   CC      arch/um/drivers/stderr_console.o
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
>     placated -- and just like all other arch's have.



Assuming the UML maintainer will pick up this:

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>







>  arch/um/include/uapi/asm/Kbuild |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/um/include/uapi/asm/Kbuild b/arch/um/include/uapi/asm/Kbuild
> new file mode 100644
> index 000000000000..f66554cd5c45
> --- /dev/null
> +++ b/arch/um/include/uapi/asm/Kbuild
> @@ -0,0 +1 @@
> +# SPDX-License-Identifier: GPL-2.0



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

