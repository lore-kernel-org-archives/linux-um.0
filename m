Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbpY8-0004JE-2z
 for linux-um@lists.infradead.org; Thu, 21 May 2020 18:04:09 +0000
Received: by mail-lj1-x242.google.com with SMTP id z6so9366670ljm.13
 for <linux-um@lists.infradead.org>; Thu, 21 May 2020 11:04:04 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id l16sm546188lfg.2.2020.05.21.11.04.00
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 11:04:01 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v16so9423065ljc.8
 for <linux-um@lists.infradead.org>; Thu, 21 May 2020 11:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
In-Reply-To: <20200521152301.2587579-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 May 2020 11:03:43 -0700
Message-ID: <CAHk-=wiQa3GNytJDdN=RKzSKfGQdPBvso+2Lmi+BpOP=BA_n6A@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
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

On Thu, May 21, 2020 at 8:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.

I could not see anything to object to in this version. So Ack from me,
but obviously I'm hoping others will try to read it through as well.

              Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

