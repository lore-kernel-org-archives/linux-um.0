Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbtOt-0001w3-Rq
 for linux-um@lists.infradead.org; Thu, 21 May 2020 22:10:53 +0000
Received: by mail-qk1-x742.google.com with SMTP id i14so8861174qka.10
 for <linux-um@lists.infradead.org>; Thu, 21 May 2020 15:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-13-hch@lst.de>
In-Reply-To: <20200521152301.2587579-13-hch@lst.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 May 2020 15:10:38 -0700
Message-ID: <CAEf4BzbDvJzbygB9T2_4YtCx8J+ESp9rhpB=BCQVDa0QBHrV0A@mail.gmail.com>
Subject: Re: [PATCH 12/23] bpf: handle the compat string in
 bpf_trace_copy_string better
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

On Thu, May 21, 2020 at 8:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> User the proper helper for kernel or userspace addresses based on
> TASK_SIZE instead of the dangerous strncpy_from_unsafe function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/trace/bpf_trace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

[...]

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

