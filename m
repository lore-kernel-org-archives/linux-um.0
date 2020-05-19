Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb5Nn-0002s0-9z
 for linux-um@lists.infradead.org; Tue, 19 May 2020 16:46:24 +0000
Received: by mail-lj1-x244.google.com with SMTP id z18so411280lji.12
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:46:22 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id m4sm77848ljb.46.2020.05.19.09.46.18
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 09:46:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u6so452610ljl.6
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-13-hch@lst.de>
 <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
 <20200519164146.GA28313@lst.de>
In-Reply-To: <20200519164146.GA28313@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2020 09:46:02 -0700
Message-ID: <CAHk-=whVd4evLe-pi7VNrh4Htp1SjogWtEqgot6Ta+kavyqamg@mail.gmail.com>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
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
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org

On Tue, May 19, 2020 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I had a lot of folks complaining about things like:
>
> #ifdef CONFIG_FOO
>         if (foo)
>                 do_stuff();
>         else
> #endif
>                 do_something_else();
>
> which I personally don't mind at all, so I switched to this style.

Well, I don't particularly like that style either, it is _very_ easy
to get wrong when you edit it later (and various indentation checkers
tend to be very unhappy about it too).

But that's why I like trying to just make simple helper functions instead.

Yeah, it's often a few more lines of code (if only because of the
extra function definition etc), but with good naming and sane
arguments those few extra lines can also help make it much more
understandable in the process, and it gives you a nice place to add
commentary for the really odd cases (comments inside code that then
does other things often make things just harder to see).

             Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

