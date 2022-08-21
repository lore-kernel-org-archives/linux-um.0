Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPhvt-0094AU-Ge
	for linux-um@lists.infradead.org; Sun, 21 Aug 2022 10:11:55 +0000
Received: by mail-ej1-x62c.google.com with SMTP id h22so5931512ejk.4
        for <linux-um@lists.infradead.org>; Sun, 21 Aug 2022 03:11:49 -0700 (PDT)
Date: Sun, 21 Aug 2022 12:11:45 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] asm goto: eradicate CC_HAS_ASM_GOTO
Message-ID: <YwIE4WDJXWK/LOR6@gmail.com>
References: <CAADnVQJFc9AnH_9CW+bSRotkKvOmkO9jq-RF6dmyPYOpq691Yg@mail.gmail.com>
 <20220819190640.2763586-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220819190640.2763586-1-ndesaulniers@google.com>
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
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Borislav Petkov <bp@suse.de>, Alexei Starovoitov <alexei.starovoitov@gmail.com>


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
> The minimum supported versions of these tools for the build according to
> Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.
> 
> Remove the feature detection script, Kconfig option, and clean up some
> fallback code that is no longer supported.
> 
> The removed script was also testing for a GCC specific bug that was
> fixed in the 4.7 release.
> 
> Also remove workarounds for bpftrace using clang older than 9.0.0, since
> other BPF backend fixes are required at this point.
> 
> Link: https://lore.kernel.org/lkml/CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com/
> Link: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> Acked-by: Borislav Petkov <bp@suse.de>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Good riddance.

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

