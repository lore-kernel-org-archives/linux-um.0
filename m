Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8606FA3755
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6vlq4KZuWy+cpagWnMP/i1WxsOpBsApAGszCvaZ6aE=; b=PgKNyuTnk895v1lrLLnFXgO342
	xyEhSBarquVcanDgacJD9i+3QMl4buGdM/DJfPSFwcqWVhB8t0XRYpnJ582shub0UV7ZksC2l+a0E
	YzAlBUB7mgFnbJhAluJEnS6owjR4meJst4KwWCDXkCygvL/GD+lZbOCtelox3so1DwY7jQE/PEqbV
	QGFCyqf3/piMWSKmUO3R2Cyzifm8a4jAPFWC4Fxq5jZDNUdT9BEfVNzH7DejFrMonxJofR3rYU2N4
	RmzY/l95iFCPcQbSrzy90XjbYdgRBsc572Mmj7DkcjajTVdAPAVTIcfF59URdVXkRUkzQMP6WW4Zj
	WYxXKVsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7nQ-0000000GHIU-1MHm;
	Fri, 13 Sep 2024 15:01:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7n7-0000000GH5Q-1wbs;
	Fri, 13 Sep 2024 15:00:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F10B35C549C;
	Fri, 13 Sep 2024 15:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536A1C4CECE;
	Fri, 13 Sep 2024 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726239656;
	bh=BA0ANnltDBBfuoBltj9aaFdaXEL//Iks38XJnB02U/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YAJMkQFcS9yQrD3CD9uf2YDAnPedZRu2sdG3Uq7zy8+8g4fHsdnaV9YMu/zLJ/1tj
	 EDiCdYnV0pGG/cGSGCoqzc1yz3NAQwdRBBLRfL0AaT5mhRSd5SqOtQjToavlsk96bb
	 oKdYkALvWRv8THfAoHVYOAKmMboDnCW5qhSOfsTXSAkiRSZcMGaGh7XxCBtwPbd5yo
	 iYcY5nqsZThg8+lFTkl4wHHIxP84VsBur9fkHWLMiLx+uY355fMP3Bd0gFRq3KpUT4
	 TIJSScKe0wBqYY1i+xFQfTmvYKL4lkyD4Paj6wDyvXKCliGwP8nsVtdZV47PWrdook
	 qWRlseRXwzJPA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75de9a503so25797881fa.0;
        Fri, 13 Sep 2024 08:00:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzUL8+Zebn9B+XgCm7ciGeTatsPr9/FzFqplzqatCztOb3yKbvQ0/SPARVmJGT6GaYKhQWb5z+5II=@lists.infradead.org, AJvYcCWQZF/hoeE7xlGyyAOO0wZs8LfszfzeyyT62mL9hq4OBK3MkUnen0vsgYLhPODQ3t+Yi7GodV7MVaTP5TwKc58=@lists.infradead.org, AJvYcCWaYolRzmMxcq3jSCKMh9TNrh9vcnqTIFTW59ffz5V7mqoOy4wOELWOmNIBsaEtz/nS8Vj5qNSLvPIa6WY=@lists.infradead.org, AJvYcCX2/39JK8T5RAztR2wZKdJPHRPNSzocrPexsgmx5tOIKOTPwZp/32APRHv7sHnytX2Yql6krtHgZqfWvgJHC/vP@lists.infradead.org
X-Gm-Message-State: AOJu0YzEoYUn/DIslLWcBjaRbQ7snw7HMNfbBk6HEe0ehA6EEhkLlFPI
	i+4a9sjI2pJjfsd7oUH2mCgeHOwiMHythagkxPfBgFVErBHe+NWKVo01qnYyxTC4VBMgYctvB6l
	sQyN9P45Y3zFZ1d13K88kfKl2/ms=
X-Google-Smtp-Source: AGHT+IEIp2MygUsW5Tc1gnqrEXhSi4Y5LfaJ7pDs2t1FcVSY61BEs2pVKMYAU/+O+nJIsawLe6NqpBRTPpsi7cWLSzQ=
X-Received: by 2002:a05:651c:1a0c:b0:2f0:1e0a:4696 with SMTP id
 38308e7fff4ca-2f787dabe7emr39035411fa.7.1726239653924; Fri, 13 Sep 2024
 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240909064730.3290724-1-rppt@kernel.org> <20240909064730.3290724-8-rppt@kernel.org>
In-Reply-To: <20240909064730.3290724-8-rppt@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 17:00:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>
Message-ID: <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] execmem: add support for cache of large ROX pages
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christoph Hellwig <hch@infradead.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_080057_790099_B3650A48 
X-CRM114-Status: GOOD (  28.83  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Mike,

On Mon, 9 Sept 2024 at 08:51, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
>
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
>
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
>
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
>
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
>
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/execmem.h |   2 +
>  mm/execmem.c            | 289 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 286 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index dfdf19f8a5e8..7436aa547818 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -77,12 +77,14 @@ struct execmem_range {
>
>  /**
>   * struct execmem_info - architecture parameters for code allocations
> + * @fill_trapping_insns: set memory to contain instructions that will trap
>   * @ranges: array of parameter sets defining architecture specific
>   * parameters for executable memory allocations. The ranges that are not
>   * explicitly initialized by an architecture use parameters defined for
>   * @EXECMEM_DEFAULT.
>   */
>  struct execmem_info {
> +       void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
>         struct execmem_range    ranges[EXECMEM_TYPE_MAX];
>  };
>
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0f6691e9ffe6..f547c1f3c93d 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -7,28 +7,88 @@
>   */
>
>  #include <linux/mm.h>
> +#include <linux/mutex.h>
>  #include <linux/vmalloc.h>
>  #include <linux/execmem.h>
> +#include <linux/maple_tree.h>
>  #include <linux/moduleloader.h>
>  #include <linux/text-patching.h>
>
> +#include <asm/tlbflush.h>
> +
> +#include "internal.h"
> +
>  static struct execmem_info *execmem_info __ro_after_init;
>  static struct execmem_info default_execmem_info __ro_after_init;
>
> -static void *__execmem_alloc(struct execmem_range *range, size_t size)
> +#ifdef CONFIG_MMU
> +struct execmem_cache {
> +       struct mutex mutex;
> +       struct maple_tree busy_areas;
> +       struct maple_tree free_areas;
> +};
> +
> +static struct execmem_cache execmem_cache = {
> +       .mutex = __MUTEX_INITIALIZER(execmem_cache.mutex),
> +       .busy_areas = MTREE_INIT_EXT(busy_areas, MT_FLAGS_LOCK_EXTERN,
> +                                    execmem_cache.mutex),
> +       .free_areas = MTREE_INIT_EXT(free_areas, MT_FLAGS_LOCK_EXTERN,
> +                                    execmem_cache.mutex),
> +};
> +
> +static void execmem_cache_clean(struct work_struct *work)
> +{
> +       struct maple_tree *free_areas = &execmem_cache.free_areas;
> +       struct mutex *mutex = &execmem_cache.mutex;
> +       MA_STATE(mas, free_areas, 0, ULONG_MAX);
> +       void *area;
> +
> +       mutex_lock(mutex);
> +       mas_for_each(&mas, area, ULONG_MAX) {
> +               size_t size;
> +
> +               if (!xa_is_value(area))
> +                       continue;
> +
> +               size = xa_to_value(area);
> +
> +               if (IS_ALIGNED(size, PMD_SIZE) &&
> +                   IS_ALIGNED(mas.index, PMD_SIZE)) {
> +                       void *ptr = (void *)mas.index;
> +
> +                       mas_erase(&mas);
> +                       vfree(ptr);
> +               }
> +       }
> +       mutex_unlock(mutex);
> +}
> +
> +static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
> +
> +static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable)
> +{
> +       if (execmem_info->fill_trapping_insns)
> +               execmem_info->fill_trapping_insns(ptr, size, writable);
> +       else
> +               memset(ptr, 0, size);

Does this really have to be a function pointer with a runtime check?

This could just be a __weak definition, with the arch providing an
override if the memset() is not appropriate.

