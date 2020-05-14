Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ3qd-0006Aa-RY
 for linux-um@lists.infradead.org; Thu, 14 May 2020 02:43:50 +0000
Received: by mail-lf1-x143.google.com with SMTP id s9so1297780lfp.1
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 19:43:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id a11sm620225lji.62.2020.05.13.19.43.40
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 19:43:40 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r17so1257797lff.9
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 19:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org>
 <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
 <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
In-Reply-To: <20200514100009.a8e6aa001f0ace5553c7904f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 19:43:24 -0700
Message-ID: <CAHk-=wjP8ysEZnNFi_+E1ZEFGpcbAN8kbYHrCnC93TX6XX+jEQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
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
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Wed, May 13, 2020 at 6:00 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > But we should likely at least disallow it entirely on platforms where
> > we really can't - or pick one hardcoded choice. On sparc, you really
> > _have_ to specify one or the other.
>
> OK. BTW, is there any way to detect the kernel/user space overlap on
> memory layout statically? If there, I can do it. (I don't like
> "if (CONFIG_X86)" thing....)
> Or, maybe we need CONFIG_ARCH_OVERLAP_ADDRESS_SPACE?

I think it would be better to have a CONFIG variable that
architectures can just 'select' to show that they are ok with separate
kernel and user addresses.

Because I don't think we have any way to say that right now as-is. You
can probably come up with hacky ways to approximate it, ie something
like

    if (TASK_SIZE_MAX > PAGE_OFFSET)
        .... they overlap ..

which would almost work, but..

                 Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

