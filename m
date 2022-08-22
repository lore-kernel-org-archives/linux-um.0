Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0ff-005KOo-H5
	for linux-um@lists.infradead.org; Mon, 22 Aug 2022 06:12:24 +0000
Received: by mail-ot1-x334.google.com with SMTP id 53-20020a9d0838000000b006371d896343so7043994oty.10
        for <linux-um@lists.infradead.org>; Sun, 21 Aug 2022 23:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJFc9AnH_9CW+bSRotkKvOmkO9jq-RF6dmyPYOpq691Yg@mail.gmail.com>
 <20220819190640.2763586-1-ndesaulniers@google.com> <CAHk-=whLcuvDDS3rZfEgDrwbdJrTx8HCRNiZ5cDc80-_gzHCxw@mail.gmail.com>
In-Reply-To: <CAHk-=whLcuvDDS3rZfEgDrwbdJrTx8HCRNiZ5cDc80-_gzHCxw@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 22 Aug 2022 08:11:44 +0200
Message-ID: <CA+icZUUX1gPvnExa=zyVqB8xYOTai+nfHp6E7+qRE2mXXa2M=A@mail.gmail.com>
Subject: Re: [PATCH v2] asm goto: eradicate CC_HAS_ASM_GOTO
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: sedat.dilek@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, llvm@lists.linux.dev, Alexandre Belloni <alexandre.belloni@bootlin.com>, Borislav Petkov <bp@suse.de>, Alexei Starovoitov <alexei.starovoitov@gmail.com>

On Sun, Aug 21, 2022 at 7:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Applied directly, just because I love seeing old nasty stuff like this go away.
>
>              Linus

Hi,

Small nitpick:

--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
...
-#if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CONFIG_CC_HAS_ASM_GOTO)
+#ifndef __GCC_ASM_FLAG_OUTPUTS__
...
-#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) ||
!defined(CONFIG_CC_HAS_ASM_GOTO) */
+#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
...
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) ||
!defined(CONFIG_CC_HAS_ASM_GOTO) */
+#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) */

Shouldn't that be...

#if !defined(__GCC_ASM_FLAG_OUTPUTS__)

...to fit the 2 comments?

Best regards,
-Sedat-

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

