Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfa5-0006tp-E4
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:35:00 +0000
Received: by mail-wm1-x341.google.com with SMTP id j19so491077wmi.2
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200212100259.80438-1-andriy.shevchenko@linux.intel.com>
 <20200312170456.GG1922688@smile.fi.intel.com>
In-Reply-To: <20200312170456.GG1922688@smile.fi.intel.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:34:44 +0200
Message-ID: <CAFLxGvz7a5kZyP78+U1Dm=v2WpZMUjaU4sMo_6bcWd_fLM8VyQ@mail.gmail.com>
Subject: Re: [PATCH v2] um: Don't use console_drivers directly
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Thomas Meyer <thomas@m3y3r.de>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Mar 12, 2020 at 6:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 12, 2020 at 12:02:59PM +0200, Andy Shevchenko wrote:
> > console_drivers is kind of (semi-)private variable to the console code.
> > Direct use of it make us stuck with it being exported here and there.
> > Reduce use of console_drivers by replacing it with for_each_console().
>
> Any comments?
>
> > Cc: Thomas Meyer <thomas@m3y3r.de>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: fix condition (we do NOT want to have a console), remove confusing comment
> >  arch/um/kernel/kmsg_dump.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> > index 98bdf69e4c2e..e4abac6c9727 100644
> > --- a/arch/um/kernel/kmsg_dump.c
> > +++ b/arch/um/kernel/kmsg_dump.c
> > @@ -9,20 +9,19 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >                               enum kmsg_dump_reason reason)
> >  {
> >       static char line[1024];
> > -
> > +     struct console *con;
> >       size_t len = 0;
> > -     bool con_available = false;
> >
> >       /* only dump kmsg when no console is available */
> >       if (!console_trylock())
> >               return;
> >
> > -     if (console_drivers != NULL)
> > -             con_available = true;
> > +     for_each_console(con)
> > +             break;
> >
> >       console_unlock();
> >
> > -     if (con_available == true)
> > +     if (con)
> >               return;
> >
> >       printf("kmsg_dump:\n");
> > --

Thanks for cleaning this up, applied.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

