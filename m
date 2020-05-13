Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYxNV-0001e3-Gw
 for linux-um@lists.infradead.org; Wed, 13 May 2020 19:49:18 +0000
Received: by mail-lf1-x143.google.com with SMTP id c21so575270lfb.3
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 12:49:15 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id c79sm332486lfg.29.2020.05.13.12.49.10
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:49:11 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x73so582858lfa.2
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-15-hch@lst.de>
 <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
 <20200513194003.GA31028@lst.de>
In-Reply-To: <20200513194003.GA31028@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 12:48:54 -0700
Message-ID: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
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

On Wed, May 13, 2020 at 12:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> We do export something like it, currently it is called
> probe_kernel_address, and the last patch renames it to
> get_kernel_nofault.  However it is implemented as a wrapper
> around probe_kernel_address / copy_from_kernel_nofault and thus
> not quite as efficient and without the magic goto semantics.

Looking at the current users of "probe_kernel_read()", it looks like
it's almost mostly things that just want a single byte or word.

It's not 100% that: we definitely do several things that want the
"copy" semantics vs the "get" semantics: on the x86 side we have
CALL_INSN_SIZE and MAX_INSN_SIZE, and the ldttss_desc.

But the bulk of them do seem to be a single value.

I don't know if performance really matters here, but to me the whole
"most users seem to want to read a single value" is what makes me
think that maybe that should be the primary model, rather than have
the copy model be the primary one and then we implement the single
value case (badly) with a copy.

It probably doesn't matter that much. I certainly wouldn't hold this
series up over it - it can be a future thing.

         Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

