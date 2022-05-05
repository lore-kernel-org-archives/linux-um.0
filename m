Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmegS-00Gvto-Bo
 for linux-um@lists.infradead.org; Thu, 05 May 2022 16:50:33 +0000
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 245Go9ZQ000920
 for <linux-um@lists.infradead.org>; Fri, 6 May 2022 01:50:09 +0900
Received: by mail-pj1-f42.google.com with SMTP id o69so4703064pjo.3
 for <linux-um@lists.infradead.org>; Thu, 05 May 2022 09:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 6 May 2022 01:49:00 +0900
Message-ID: <CAK7LNATnCOKcbFXDY2Qik=6AJ31fQLKO+NW6fD-xY-muV5UQ-A@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost, 
 LTO, MODULE_REL_CRCS)
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
>
> This is the third batch of cleanups in this development cycle.


This series is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
lto-cleanup-v3








-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

