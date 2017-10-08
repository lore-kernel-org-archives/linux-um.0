Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 8 Oct 2017 13:18:24 +0200
From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH] um: Fix kcov crash before kernel is started.
Message-ID: <20171008111614.2d54jehehv4vxa6q@olymp>
References: <20171008103158.14107-1-thomas@m3y3r.de>
 <2201510.o3ITaGZhUC@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2201510.o3ITaGZhUC@blindfold>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Oct 08, 2017 at 12:44:12PM +0200, Richard Weinberger wrote:
> Am Sonntag, 8. Oktober 2017, 12:31:58 CEST schrieb Thomas Meyer:
> > UMLs current_thread_info() unconditionally assumes that the top of the stack
> > contains the thread_info structure. But on UML the __sanitizer_cov_trace_pc
> > function is called for *all* functions! This results in an early crash:
> > 
> > Prevent kcov from using invalid curent_thread_info() data by checking
> > the system_state.
> > 
> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> > ---
> >  kernel/kcov.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 3f693a0f6f3e..d601c0e956f6 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -56,6 +56,12 @@ void notrace __sanitizer_cov_trace_pc(void)
> >  	struct task_struct *t;
> >  	enum kcov_mode mode;
> > 
> > +#ifdef CONFIG_UML
> > +	if(!(system_state == SYSTEM_SCHEDULING ||
> > +	     system_state == SYSTEM_RUNNING))
> > +		return;
> > +#endif
> 
> Hmm, and why does it work on all other archs then?

Hi,

I guess UML is different then other archs! But to be honest I'm not sure
why. I assume that __sanitizer_cov_trace_pc on other archs isn't called
that early, or that curent_thread_info returns NULL on other archs when
the first task isn't running yet.

But as I fail to use/setup the qemu gdb attachment to debug early x86_64 code
I can't say exactly why.

Maybe someone how knows the inner workings of x86_64 and/or kcov can
answer this question!

> 
> Thanks,
> //richard
> 

