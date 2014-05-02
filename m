MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1399045268-18344-1-git-send-email-geert@linux-m68k.org>
References: <1399045268-18344-1-git-send-email-geert@linux-m68k.org>
Date: Fri, 2 May 2014 17:44:36 +0200
Message-ID: <CAMuHMdU=YJ-W9KaE7Y4Q0pYEQ=rb9GKG7qQX1tsm2AJ8AC3bhQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.15-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, May 2, 2014 at 5:41 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.15-rc3[1]  to v3.15-rc2[3], the summaries are:
>   - build errors: +5/-9

  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: 'TMPFS_MAGIC'
undeclared (first use in this function):  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: (Each
undeclared identifier is reported only once:  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: for each
function it appears in.):  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: linux/magic.h:
No such file or directory:  => 16:25

um-defconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7427/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7401/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

