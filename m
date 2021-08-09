MIME-Version: 1.0
Date: Mon, 9 Aug 2021 09:50:05 +0200
References: <20210809073738.200237-1-geert@linux-m68k.org>
In-Reply-To: <20210809073738.200237-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdXdHx_7t51F+wGDa1oigJnGt4FDBYHvx58FWVv_iGVxDg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Aug 9, 2021 at 9:40 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc4[1] to v5.14-rc3[3], the summaries are:
>   - build errors: +5/-0

  + /kisskb/src/drivers/dma/idxd/init.c: error: implicit declaration
of function 'cpu_feature_enabled'
[-Werror=implicit-function-declaration]:  => 805:7
  + /kisskb/src/drivers/dma/idxd/perfmon.h: error: 'struct perf_event'
has no member named 'pmu':  => 24:13, 35:13
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  =>
74:6
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_eax' [-Werror=implicit-function-declaration]:  =>
64:18
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  =>
17:31

um-x86_64/um-allyesconfig
(seen before on v5.14-rc2)

>   - build warnings: +3/-0

  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame
size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]:
=> 98:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of
3168 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  =>
2207:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of
7192 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  =>
2367:1

s390x-gcc4.9/s390-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c500bee1c5b2f1d59b1081ac879d73268ab0ff17/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ff1176468d368232b684f75e82563369208bc371/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

