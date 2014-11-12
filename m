MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1415785566-12758-1-git-send-email-geert@linux-m68k.org>
References: <1415785566-12758-1-git-send-email-geert@linux-m68k.org>
Date: Wed, 12 Nov 2014 10:48:14 +0100
Message-ID: <CAMuHMdXkFo--38rRKSpGTb8U58KavPzmm7vwwdN6_SP01Zxt8w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.18-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 12, 2014 at 10:46 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.18-rc4[1]  to v3.18-rc3[3], the summaries are:
>   - build errors: +5/-6

  + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: 'AT_FDCWD'
undeclared (first use in this function):  => 378
  + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: (Each
undeclared identifier is reported only once:  => 378
  + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: for each
function it appears in.):  => 378

um-defconfig

  + error: No rule to make target /etc/sound/dsp001.ld:  => N/A

i386-randconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8061/ (120 out of 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8044/ (120 out of 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

