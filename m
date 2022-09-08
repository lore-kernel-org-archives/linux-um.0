MIME-Version: 1.0
Date: Thu, 8 Sep 2022 19:45:58 +0200
References: <20220908125401.28130-1-wangjianli@cdjrlc.com>
	<514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
In-Reply-To: <514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
Message-ID: <CAMuHMdXtPREdgoXK4wyBJiZmubDtsT5Cjjn44MzGVnpu_Ph=YQ@mail.gmail.com>
Subject: Re: [PATCH] um/kernel: fix repeated words in comments
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: wangjianli <wangjianli@cdjrlc.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, Sep 8, 2022 at 2:56 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2022-09-08 at 20:54 +0800, wangjianli wrote:
> > Delete the redundant word 'in'.
> >
> > Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> > ---
> >  arch/um/kernel/physmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> > index e7c7b53a1435..91485119ae67 100644
> > --- a/arch/um/kernel/physmem.c
> > +++ b/arch/um/kernel/physmem.c
> > @@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
> >  );
> >
> >  /*
> > - * This list is constructed in parse_iomem and addresses filled in in
> > + * This list is constructed in parse_iomem and addresses filled in
> >   * setup_iomem, both of which run during early boot.  Afterwards, it's
> >
> Fine, I guess, but honestly - that sentence doesn't parse well either

Not fine, the repeated "in" is correct.
Q: "Where are addresses filled in?"
A: "In setup_iomem".

> way. Might be worth addressing that at the same time...

addresses are filled in?

General note: please stop submitting these patches for auto-detected
repeated words.  There are too many false positives.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

