Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161121082721.GA22520@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com> <20161117020610.5302-7-khuey@kylehuey.com>
 <20161118081444.GC15912@gmail.com> <alpine.DEB.2.20.1611180942100.3615@nanos> <20161121082721.GA22520@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 22 Nov 2016 09:26:11 -0800
Message-ID: <CALCETrVayvjbnF_ancsnUKqaMPiPduAhrykU7McU6VpouLZDnA@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Dmitry Safonov <dsafonov@virtuozzo.com>, Nadav Amit <nadav.amit@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, X86 ML <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Paolo Bonzini <pbonzini@redhat.com>, Kyle Huey <me@kylehuey.com>, Dave Hansen <dave.hansen@linux.intel.com>, Robert O'Callahan <robert@ocallahan.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Shuah Khan <shuah@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Matlack <dmatlack@google.com>, Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>, Richard Weinberger <richard@nod.at>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Nov 21, 2016 12:27 AM, "Ingo Molnar" <mingo@kernel.org> wrote:
>
>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > On Fri, 18 Nov 2016, Ingo Molnar wrote:
> > > * Kyle Huey <me@kylehuey.com> wrote:
> > > > + if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
> > > > +     test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
> > > > +         set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
> > > > + }
> > > > +
> > >
> > > Why not cache the required MSR value in the task struct instead?
> > >
> > > That would allow something much more obvious and much faster, like:
> > >
> > >     if (prev_p->thread.misc_features_val != next_p->thread.misc_features_val)
> > >             wrmsrl(MSR_MISC_FEATURES_ENABLES, next_p->thread.misc_features_val);
> > >
> > > (The TIF flag maintenance is still required to get into __switch_to_xtra().)
> > >
> > > It would also be easy to extend without extra overhead, should any other feature
> > > bit be added to the MSR in the future.
> >
> > I doubt that. There are feature enable bits coming up which are not related to
> > tasks.
>
> Any inefficiencies resulting from such features should IMHO be carried by those
> features, not by per task features - but:
>
> > [...] So if we have switches enabling/disabling global features, then we would
> > be forced to chase all threads in order to update all misc_features thread
> > variables. Surely not what we want to do.
>
> What switches would those be? We generally don't twiddle global CPU features post
> bootup - we pick a model on bootup and go with that.

I don't see what problem we're trying to solve here.  If we end up
with a mix of global (and changeable!) features and per-task features,
we can just do:

wrmsrl(MSR_MISC_FEATURES_ENABLES, global_misc_features_val |
next_p->thread.misc_features_val);

This is *still* way faster than rdmsr.

