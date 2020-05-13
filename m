Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ0Pc-0003nk-0T
 for linux-um@lists.infradead.org; Wed, 13 May 2020 23:03:41 +0000
Received: by mail-lj1-x242.google.com with SMTP id j3so1399879ljg.8
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:03:39 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id m22sm429160lji.75.2020.05.13.16.03.36
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 16:03:36 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 188so925036lfa.10
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
In-Reply-To: <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 16:03:20 -0700
Message-ID: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
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
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Wed, May 13, 2020 at 3:36 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> It's used for both.

Daniel, BPF real;ly needs to make up its mind about that.

You *cannot* use ti for both.

Yes, it happens to work on x86 and some other architectures.

But on other architectures, the exact same pointer value can be a
kernel pointer or a user pointer.

> Given this is enabled on pretty much all program types, my
> assumption would be that usage is still more often on kernel memory than user one.

You need to pick one.

If you know it is a user pointer, use strncpy_from_user() (possibly
with disable_pagefault() aka strncpy_from_user_nofault()).

And if you know it is a kernel pointer, use strncpy_from_unsafe() (aka
strncpy_from_kernel_nofault()).

You really can't pick the "randomly one or the other guess what I mean " option.

                  Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

