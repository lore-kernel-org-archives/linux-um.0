Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb5Cy-0004J0-Pt
 for linux-um@lists.infradead.org; Tue, 19 May 2020 16:35:13 +0000
Received: by mail-lj1-x22b.google.com with SMTP id g1so406482ljk.7
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:35:10 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id y20sm70889lji.31.2020.05.19.09.35.06
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 09:35:06 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x22so76396lfd.4
 for <linux-um@lists.infradead.org>; Tue, 19 May 2020 09:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de>
In-Reply-To: <20200519134449.1466624-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2020 09:34:49 -0700
Message-ID: <CAHk-=whj0zVP-ErHcqGNrM0-bZ+TvSFAwpEd+pKFadZeFXj5PA@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v3
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

On Tue, May 19, 2020 at 6:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  - rebased on 5.7-rc6 with the bpf trace format string changes

Other than the critique about illegible conditionals in the result
when doing that bpf/trace conversion, I like it.

                  Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

