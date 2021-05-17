Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210514220942.879805-2-arnd@kernel.org>
 <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
In-Reply-To: <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 17 May 2021 10:42:54 +0200
Message-ID: <CAK8P3a02V8k6aGkqtc0A7PiAwhJDCw6yMW=m4nmTmgVbwy316g@mail.gmail.com>
Subject: Re: [PATCH 1/5] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, May 17, 2021 at 9:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sat, May 15, 2021 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This is a preparation for changing over architectures to the
> > generic implementation one at a time. As there are no callers
> > of either __strncpy_from_user() or __strnlen_user(), fold these
> > into the strncpy_from_user() strnlen_user() functions to make
>
> ... and ...

Fixed, thanks!

      Arnd

