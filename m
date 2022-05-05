Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbs4-00GA5K-Gk
 for linux-um@lists.infradead.org; Thu, 05 May 2022 13:50:27 +0000
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 245Do26n009652
 for <linux-um@lists.infradead.org>; Thu, 5 May 2022 22:50:03 +0900
Received: by mail-pl1-f177.google.com with SMTP id i17so4434873pla.10
 for <linux-um@lists.infradead.org>; Thu, 05 May 2022 06:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-3-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-3-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 5 May 2022 22:48:55 +0900
Message-ID: <CAK7LNAREQt5rPGK8zsti_UA-dGFKfqHsVWbSgMLw-yLoeNkJeA@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] modpost: change the license of EXPORT_SYMBOL to
 bool type
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
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-um@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>

On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, enum export is tristate, but export_unknown does not make
> sense in any way.
>
> If the symbol name starts with "__ksymtab_", but the section name
> does not start with "___ksymtab+" or "___ksymtab_gpl+", it is not
> an exported symbol. The variable name just happens to start with
> "__ksymtab_". Do not call sym_add_exported() in this case.
>
> __ksymtab_* is internally by EXPORT_SYMBOL(_GPL) but somebody may

I mean
"... is internally used by ..."




-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

