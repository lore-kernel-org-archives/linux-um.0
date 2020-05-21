Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbtOw-0001xj-N8
 for linux-um@lists.infradead.org; Thu, 21 May 2020 22:10:55 +0000
Received: by mail-qk1-x741.google.com with SMTP id w3so3380931qkb.6
 for <linux-um@lists.infradead.org>; Thu, 21 May 2020 15:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-14-hch@lst.de>
In-Reply-To: <20200521152301.2587579-14-hch@lst.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 May 2020 15:10:42 -0700
Message-ID: <CAEf4BzZCp3w9YB0Hg1yyfXFTTCv_Kvi2Xc5RXm7DU2kgm31EUg@mail.gmail.com>
Subject: Re: [PATCH 13/23] bpf: rework the compat kernel probe handling
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
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, Networking <netdev@vger.kernel.org>, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>

On Thu, May 21, 2020 at 8:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of using the dangerous probe_kernel_read and strncpy_from_unsafe
> helpers, rework the compat probes to check if an address is a kernel or
> userspace one, and then use the low-level kernel or user probe helper
> shared by the proper kernel and user probe helpers.  This slightly
> changes behavior as the compat probe on a user address doesn't check
> the lockdown flags, just as the pure user probes do.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good, thanks.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/trace/bpf_trace.c | 109 ++++++++++++++++++++++++---------------
>  1 file changed, 67 insertions(+), 42 deletions(-)
>

[...]

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

