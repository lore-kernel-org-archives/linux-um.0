MIME-Version: 1.0
Date: Wed, 13 Mar 2019 11:30:24 +0100
References: <20190313101439.7092-1-brgl@bgdev.pl>
In-Reply-To: <20190313101439.7092-1-brgl@bgdev.pl>
Message-ID: <CAMuHMdWMd36X025PF2JODUH1658HECSK=d_imQE-4N0vY=Gvtw@mail.gmail.com>
Subject: Re: [PATCH] um: define set_pte_at() as a static inline function, not
 a macro
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

On Wed, Mar 13, 2019 at 11:16 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When defined as macro, the mm argument is unused and subsequently the
> variable passed as mm is considered unused by the compiler. This fixes
> a build warning.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

