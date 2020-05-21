Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbtOp-0001ur-1r
 for linux-um@lists.infradead.org; Thu, 21 May 2020 22:10:48 +0000
Received: by mail-qk1-x744.google.com with SMTP id f13so8944402qkh.2
 for <linux-um@lists.infradead.org>; Thu, 21 May 2020 15:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-12-hch@lst.de>
In-Reply-To: <20200521152301.2587579-12-hch@lst.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 May 2020 15:10:33 -0700
Message-ID: <CAEf4BzZWW_8jKWmbth6=i2+JVx9JKKa7o6vBSQwswRd2sNLEkQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] bpf: factor out a bpf_trace_copy_string helper
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

On Thu, May 21, 2020 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Split out a helper to do the fault free access to the string pointer
> to get it out of a crazy indentation level.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/trace/bpf_trace.c | 42 +++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>

[...]

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

