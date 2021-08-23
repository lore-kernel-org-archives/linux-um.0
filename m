MIME-Version: 1.0
Date: Mon, 23 Aug 2021 13:16:08 +0200
References: <20210823104942.1371825-1-geert@linux-m68k.org>
In-Reply-To: <20210823104942.1371825-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdVnF6yAf6ffUd7Jy2p03fbTNz6ymVGU5dUSkr18b=fo7Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Aug 23, 2021 at 12:52 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc6[1] to v5.14-rc5[3], the summaries are:
>   - build errors: +2/-0

  + /kisskb/src/drivers/dma/idxd/init.c: error: implicit declaration
of function 'cpu_feature_enabled'
[-Werror=implicit-function-declaration]:  => 815:7
  + /kisskb/src/drivers/dma/idxd/perfmon.h: error: 'struct perf_event'
has no member named 'pmu':  => 35:13, 24:13

um-x86_64/um-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7c60610d476766e128cc4284bb6349732cbd6606/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/36a21d51725af2ce0700c6ebcb6b9594aac658a6/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

