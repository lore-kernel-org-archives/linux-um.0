Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200621043737.pb6JV%akpm@linux-foundation.org>
 <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com> <202006221445.36E03CCBE9@keescook>
In-Reply-To: <202006221445.36E03CCBE9@keescook>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 23 Jun 2020 00:00:39 +0200
Message-ID: <CAFLxGvw4NeBw3tDEnvL4USxgp--=vT1iXc6-tzAd_NkWCmUNFA@mail.gmail.com>
Subject: Re: mmotm 2020-06-20-21-36 uploaded (lkdtm/bugs.c)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Randy Dunlap <rd.dunlab@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Michal Hocko <mhocko@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Jun 22, 2020 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 08:37:17AM -0700, Randy Dunlap wrote:
> > On 6/20/20 9:37 PM, akpm@linux-foundation.org wrote:
> > > The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to
> > >
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > mmotm-readme.txt says
> > >
> > > README for mm-of-the-moment:
> > >
> > > http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> >
> > drivers/misc/lkdtm/bugs.c has build errors when building UML for i386
> > (allmodconfig or allyesconfig):
> >
> >
> > In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
> > ../arch/x86/um/asm/desc.h:7:0: warning: "LDT_empty" redefined
> >  #define LDT_empty(info) (\
> >
> > In file included from ../arch/um/include/asm/mmu.h:10:0,
> >                  from ../include/linux/mm_types.h:18,
> >                  from ../include/linux/sched/signal.h:13,
> >                  from ../drivers/misc/lkdtm/bugs.c:11:
> > ../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
> >  #define LDT_empty(info) (_LDT_empty(info))
>
> The LKDTM test landed a while ago:
> b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
>
> and nothing has touched arch/x86/um/asm/desc.h nor
> arch/x86/um/asm/mm_context.h in a while either.
>
> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?

True that, we can rip the file.

-- 
Thanks,
//richard

