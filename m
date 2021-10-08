Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYzCy-004LC5-Gb
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 23:23:21 +0000
Received: by mail-wr1-x42b.google.com with SMTP id e3so621018wrc.11
 for <linux-um@lists.infradead.org>; Fri, 08 Oct 2021 16:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211008215133.9371-1-rdunlap@infradead.org>
In-Reply-To: <20211008215133.9371-1-rdunlap@infradead.org>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Oct 2021 07:23:05 +0800
Message-ID: <CABVgOS=QVysVtN5seB5hp7hHAw5P0yuOaA3rgkRtEyiJu-1H6Q@mail.gmail.com>
Subject: Re: [PATCH] um: Add missing "FORCE" target when using if_changed
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
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, x86@kernel.org

On Sat, Oct 9, 2021 at 5:51 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> 'make ARCH=um' says:
>
> ../arch/x86/um/Makefile:44: FORCE prerequisite is missing
>
> and adding "FORCE" there makes it be quiet, so do it.  :)
>
> Fixes: e1f86d7b4b2a ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> Cc: x86@kernel.org
> ---

FYI, this looks identical to "uml: x86: add FORCE to user_constants.h":
http://lists.infradead.org/pipermail/linux-um/2021-September/001791.html

-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

