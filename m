Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWO64-0006Ab-Q0
 for linux-um@lists.infradead.org; Wed, 06 May 2020 17:44:42 +0000
Received: by mail-lf1-x141.google.com with SMTP id g10so2068192lfj.13
 for <linux-um@lists.infradead.org>; Wed, 06 May 2020 10:44:36 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46])
 by smtp.gmail.com with ESMTPSA id a25sm1975511lfb.87.2020.05.06.10.44.31
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 10:44:32 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t11so2077604lfe.4
 for <linux-um@lists.infradead.org>; Wed, 06 May 2020 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de>
 <20200506062223.30032-9-hch@lst.de>
In-Reply-To: <20200506062223.30032-9-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 May 2020 10:44:15 -0700
Message-ID: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
Subject: Re: [PATCH 08/15] maccess: rename strnlen_unsafe_user to
 strnlen_user_unsafe
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

On Tue, May 5, 2020 at 11:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This matches the convention of always having _unsafe as a suffix, as
> well as match the naming of strncpy_from_user_unsafe.

Hmm. While renaming them, can we perhaps clarify what the rules are?

We now have two different kinds of "unsafe". We have the
"unsafe_get_user()" kind of unsafe: the user pointer itself is unsafe
because it isn't checked, and you need to use a "user_access_begin()"
to verify.

It's the new form of "__get_user()".

And then we have the strncpy_from_user_unsafe(), which is really more
like the "probe_kernel_read()" kind of funtion, in that it's about the
context, and not faulting.

Honestly, I don't like the "unsafe" in the second case, because
there's nothing "unsafe" about the function. It's used in odd
contexts. I guess to some degree those are "unsafe" contexts, but I
think it might be better to clarify.

So while I think using a consistent convention is good, and it's true
that there is a difference in the convention between the two cases
("unsafe" at the beginning vs end), one of them is actually about the
safety and security of the operation (and we have automated logic
these days to verify it on x86), the other has nothing to do with
"safety", really.

Would it be better to standardize around a "probe_xyz()" naming?

Or perhaps a "xyz_nofault()" naming?

I'm not a huge fan of the "probe" naming, but it sure is descriptive,
which is a really good thing.

Another option would be to make it explicitly about _what_ is
"unsafe", ie that it's about not having a process context that can be
faulted in. But "xyz_unsafe_context()" is much too verbose.
"xyz_noctx()" might work.

I realize this is nit-picky, and I think the patch series as-is is
already an improvement, but I do think our naming in this area is
really quite bad.

The fact that we have "probe_kernel_read()" but then
"strncpy_from_user_unsafe()" for the _same_ conceptual difference
really tells me how inconsistent the naming for these kinds of "we
can't take page faults" is. No?

                   Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

