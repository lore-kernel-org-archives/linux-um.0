Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210515064015.GA26545@lst.de>
In-Reply-To: <20210515064015.GA26545@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Sat, 15 May 2021 11:55:10 +0200
Message-ID: <CAK8P3a2ukLgV3K3sW8gkkz6cvKh+wmP_C0av2hnYcftfXMPTWA@mail.gmail.com>
Subject: Re: [PATCH 0/5] asm-generic: strncpy_from_user/strnlen_user cleanup
Content-Type: text/plain; charset="UTF-8"
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Sat, May 15, 2021 at 8:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I generall like this consolidation, but for the patches that remote
> the arch / asm-generic versions, can you please elaborate a little
> more why the lib version is preferable?  The current commit logs are
> not very informative.

Indeed. I do remember writing the patches last year thinking "this should
really get fixed", but apparently I failed to describe the actual problem at
the time. I have gone through it again and annotated what I found now,
but I have a feeling that there were additional problems with the old
code that I still did not capture.

Sending v2 now: same code, more text.

       Arnd

