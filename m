Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfuS-0006Xu-55
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:56:01 +0000
Received: by mail-wm1-x344.google.com with SMTP id c187so17787045wme.1
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk>
 <74c04f11-4b67-d1a7-7d05-197a229b245c@cambridgegreys.com>
In-Reply-To: <74c04f11-4b67-d1a7-7d05-197a229b245c@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:55:47 +0200
Message-ID: <CAFLxGvzuDJs7B7w6eF+dC634pVrK6BJPyfUOvXoACL7toYwoPg@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Avoid NULL ptr deference if transport is unset
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard@nod.at>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-um <linux-um@lists.infradead.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Feb 17, 2020 at 8:54 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 16/02/2020 21:36, Sjoerd Simons wrote:
> > When the transport option of a vec isn't set strncmp ends up being
> > called on a NULL pointer. Better not do that.
> >
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> >
> > ---
> >
> >   arch/um/drivers/vector_kern.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> > index 0ff86391f77d..ca90666c0b61 100644
> > --- a/arch/um/drivers/vector_kern.c
> > +++ b/arch/um/drivers/vector_kern.c
> > @@ -198,6 +198,9 @@ static int get_transport_options(struct arglist *def)
> >       long parsed;
> >       int result = 0;
> >
> > +     if (transport == NULL)
> > +             return -EINVAL;
> > +
> >       if (vector != NULL) {
> >               if (kstrtoul(vector, 10, &parsed) == 0) {
> >                       if (parsed == 0) {
> >
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

