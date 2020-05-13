Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ1I7-0004wR-8z
 for linux-um@lists.infradead.org; Thu, 14 May 2020 00:00:00 +0000
Received: by mail-lf1-x144.google.com with SMTP id a9so1020110lfb.8
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:59:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id d9sm612523lfa.77.2020.05.13.16.59.56
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 16:59:56 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h4so1476156ljg.12
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org>
In-Reply-To: <20200514082054.f817721ce196f134e6820644@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 16:59:40 -0700
Message-ID: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
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

On Wed, May 13, 2020 at 4:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>
> For trace_kprobe.c current order (kernel -> user fallback) is preferred
> because it has another function dedicated for user memory.

Well, then it should just use the "strict" kernel-only one for the
non-user memory.

But yes, if there are legacy interfaces, then we might want to say
"these continue to work for the legacy case on platforms where we can
tell which kind of pointer it is from the bit pattern".

But we should likely at least disallow it entirely on platforms where
we really can't - or pick one hardcoded choice. On sparc, you really
_have_ to specify one or the other.

                  Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

