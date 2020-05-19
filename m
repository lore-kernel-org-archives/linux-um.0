Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb54N-0003jX-Sf
 for linux-um@lists.infradead.org; Tue, 19 May 2020 16:26:21 +0000
Received: by mail-lj1-x241.google.com with SMTP id l15so12648lje.9
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:26:18 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id n3sm64185ljg.6.2020.05.19.09.26.13
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 09:26:14 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id o14so400996ljp.4
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-13-hch@lst.de>
In-Reply-To: <20200519134449.1466624-13-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2020 09:25:57 -0700
Message-ID: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
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

On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +           compat && (unsigned long)unsafe_ptr < TASK_SIZE)
> +               ret = strncpy_from_user_nofault(dst, user_ptr, size);
> +       else
> +               ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);

These conditionals are completely illegible.

That's true in the next patch too.

Stop using "IS_ENABLED(config)" to make very complex conditionals.

A clear #ifdef is much better if the alternative is a conditional that
is completely impossible to actually understand and needs multiple
lines to read.

If you made this a simple helper (called "bpf_strncpy_from_unsafe()"
with that "compat" flag, perhaps?), it would be much more legible as

  /*
   * Big comment goes here about the compat behavior and
   * non-overlapping address spaces and ambiguous pointers.
   */
  static long bpf_strncpy_from_legacy(void *dest, const void
*unsafe_ptr, long size, bool legacy)
  {
  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
        if (legacy && addr < TASK_SIZE)
            return strncpy_from_user_nofault(dst, (const void __user
*) unsafe_ptr, size);
  #endif

        return strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
  }

and then you'd just use

        if (bpf_strncpy_from_unsafe(dst, unsafe_ptr, size, compat) < 0)
                memset(dst, 0, size);

and avoid any complicated conditionals, goto's, and make the code much
easier to understand thanks to having a big comment about the legacy
case.

In fact, separately I'd probably want that "compat" naming to be
scrapped entirely in that file.

"compat" generally means something very specific and completely
different in the kernel: it's the "I'm a 32-bit binary on a 64-bit
kernel" compatibility case.

Here, it's literally "BPF legacy behavior", not that kind of "compat" thing.

But that renaming is separate, although I'd start the ball rolling
with that "bpf_strncpy_from_legacy()" helper.

                Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

