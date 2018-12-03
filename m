Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxkF-0001NV-Ga
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:35:20 +0000
Received: by mail-oi1-x242.google.com with SMTP id b141so12608075oii.12
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
 <20181130033429.GK18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130033429.GK18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 15:34:57 -0800
Message-ID: <CAFd5g45+MAVaSW8HN9x57Y8Um=TV1Oa=-K8yExPBS-4KjLyciQ@mail.gmail.com>
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
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
To: mcgrof@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 7:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> > diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> > index cced829460427..bf90e678b3d71 100644
> > --- a/arch/um/kernel/trap.c
> > +++ b/arch/um/kernel/trap.c
> > @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> >       segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
> >  }
> >
> > +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> > +{
> > +     current->thread.fault_addr = fault_addr;
> > +     UML_LONGJMP(catcher, 1);
> > +}
> > +
> >  /*
> >   * We give a *copy* of the faultinfo in the regs to segv.
> >   * This must be done, since nesting SEGVs could overwrite
> > @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> >       if (!is_user && regs)
> >               current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
> >
> > -     if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > +     catcher = current->thread.fault_catcher;
>
> This and..
>
> > +     if (catcher && current->thread.is_running_test)
> > +             segv_run_catcher(catcher, (void *) address);
> > +     else if (!is_user && (address >= start_vm) && (address < end_vm)) {
> >               flush_tlb_kernel_vm();
> >               goto out;
> >       }
>
> *not this*

I don't understand. Are you saying the previous block of code is good
and this one is bad?

>
> > @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> >               address = 0;
> >       }
> >
> > -     catcher = current->thread.fault_catcher;
> >       if (!err)
> >               goto out;
> >       else if (catcher != NULL) {
> > -             current->thread.fault_addr = (void *) address;
> > -             UML_LONGJMP(catcher, 1);
> > +             segv_run_catcher(catcher, (void *) address);
> >       }
> >       else if (current->thread.fault_addr != NULL)
> >               panic("fault_addr set but no fault catcher");
>
> But with this seems one atomic change which should be submitted
> separately, its just a helper. Think it would make the actual
> change needed easier to review, ie, your needed changes would
> be smaller and clearer for what you need.

Are you suggesting that I pull out the bits needed to implement abort
in the next patch and squash it into this one?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

