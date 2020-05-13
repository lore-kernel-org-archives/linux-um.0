Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ0g3-00088A-1h
 for linux-um@lists.infradead.org; Wed, 13 May 2020 23:20:40 +0000
Received: by mail-lf1-x144.google.com with SMTP id b26so978921lfa.5
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:20:37 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id v9sm555338ljk.0.2020.05.13.16.20.33
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 16:20:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 8so989265lfp.4
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 16:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
In-Reply-To: <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 16:20:17 -0700
Message-ID: <CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
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

On Wed, May 13, 2020 at 4:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Aside from comments on list, the series looks reasonable to me. For BPF
> the bpf_probe_read() helper would be slightly penalized for probing user
> memory given we now test on copy_from_kernel_nofault() first and if that
> fails only then fall back to copy_from_user_nofault(),

Again, no.

If you can't tell that one or the other is always the right thing,
then that function is simply buggy and wrong.

On sparc and on s390, address X can be _both_ a kernel address and a
user address. You need to specify which it is (by using the proper
function). The whole "try one first, then the other" doesn't work.
They may both "work", and by virtue of that, unless you can state
"yes, we always want user space" or "yes, we always want kernel", that
"try one or the other" isn't valid.

And it can be a real security issue. If a user program can be made to
read kernel memory when BPF validated things as a user pointer, it's
an obvious security issue.

But it can be a security issue the other way around too: if the BPF
code expects to get a kernel string, but user space can fool it into
reading a user string instead by mapping something of its own into the
user space address that aliases the kernel space address, then you can
presumably fool the BPF program to do bad things too (eg mess up any
BPF packet switching routines?).

So BPF really really really needs to specify which one it is. Not
specifying it and saying "whichever" is a bug, and a security issue.

             Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

