Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZMZ6-0002jV-VX
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 22:10:44 +0000
Received: by mail-wr1-x444.google.com with SMTP id i12so20140495wro.5
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 14:10:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com>
 <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
In-Reply-To: <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:10:28 +0100
Message-ID: <CAFLxGvw_tkmAq0nGrgEs8jQFGLADDuAyUOsYhdDzAH5yhHFHEA@mail.gmail.com>
Subject: Re: [RFC v2 05/37] lkl: memory handling
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Levente Kurusa <levex@linux.com>, Octavian Purdila <tavi.purdila@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, Yuan Liu <liuyuan@google.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> LKL is a non MMU architecture and hence there is not much work left to
> do other than initializing the boot allocator and providing the page
> and page table definitions.
>
> The backstore memory is allocated via a host operation and the memory
> size to be used is specified when the kernel is started, in the
> lkl_start_kernel call.
>
> Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Yuan Liu <liuyuan@google.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/page.h          | 14 ++++++
>  arch/um/lkl/include/asm/pgtable.h       | 62 +++++++++++++++++++++++
>  arch/um/lkl/include/uapi/asm/host_ops.h |  5 ++
>  arch/um/lkl/mm/bootmem.c                | 66 +++++++++++++++++++++++++

This is also something which needs unification with UML.
UML in NOMMU mode would be LKL then...

--
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

