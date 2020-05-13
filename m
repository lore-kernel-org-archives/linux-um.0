Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYwnK-0001OL-NA
 for linux-um@lists.infradead.org; Wed, 13 May 2020 19:11:56 +0000
Received: by mail-lf1-f65.google.com with SMTP id z22so507547lfd.0
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 12:11:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id n23sm198466ljj.48.2020.05.13.12.11.43
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:11:44 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x73so491619lfa.2
 for <linux-um@lists.infradead.org>; Wed, 13 May 2020 12:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
In-Reply-To: <20200513160038.2482415-12-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 May 2020 12:11:27 -0700
Message-ID: <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org

On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +static void bpf_strncpy(char *buf, long unsafe_addr)
> +{
> +       buf[0] = 0;
> +       if (strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
> +                       BPF_STRNCPY_LEN))
> +               strncpy_from_user_nofault(buf, (void __user *)unsafe_addr,
> +                               BPF_STRNCPY_LEN);
> +}

This seems buggy when I look at it.

It seems to think that strncpy_from_kernel_nofault() returns an error code.

Not so, unless I missed where you changed the rules.

It returns the length of the string for a successful copy. 0 is
actually an error case (for count being <= 0).

So the test for success seems entirely wrong.

Also, I do wonder if we shouldn't gate this on TASK_SIZE, and do the
user trial first. On architectures where this thing is valid in the
first place (ie kernel and user addresses are separate), the test for
address size would allow us to avoid a pointless fault due to an
invalid kernel access to user space.

So I think this function should look something like

  static void bpf_strncpy(char *buf, long unsafe_addr)
  {
          /* Try user address */
          if (unsafe_addr < TASK_SIZE) {
                  void __user *ptr = (void __user *)unsafe_addr;
                  if (strncpy_from_user_nofault(buf, ptr, BPF_STRNCPY_LEN) >= 0)
                          return;
          }

          /* .. fall back on trying kernel access */
          buf[0] = 0;
          strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
BPF_STRNCPY_LEN);
  }

or similar. No?

                   Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

