Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 21 Nov 2016 09:27:21 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v12 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Message-ID: <20161121082721.GA22520@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com>
 <20161117020610.5302-7-khuey@kylehuey.com>
 <20161118081444.GC15912@gmail.com>
 <alpine.DEB.2.20.1611180942100.3615@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611180942100.3615@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 18 Nov 2016, Ingo Molnar wrote:
> > * Kyle Huey <me@kylehuey.com> wrote:
> > > +	if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
> > > +	    test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
> > > +		set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
> > > +	}
> > > +
> > 
> > Why not cache the required MSR value in the task struct instead?
> > 
> > That would allow something much more obvious and much faster, like:
> > 
> > 	if (prev_p->thread.misc_features_val != next_p->thread.misc_features_val)
> > 		wrmsrl(MSR_MISC_FEATURES_ENABLES, next_p->thread.misc_features_val);
> > 
> > (The TIF flag maintenance is still required to get into __switch_to_xtra().)
> > 
> > It would also be easy to extend without extra overhead, should any other feature 
> > bit be added to the MSR in the future.
> 
> I doubt that. There are feature enable bits coming up which are not related to 
> tasks.

Any inefficiencies resulting from such features should IMHO be carried by those 
features, not by per task features - but:

> [...] So if we have switches enabling/disabling global features, then we would 
> be forced to chase all threads in order to update all misc_features thread 
> variables. Surely not what we want to do.

What switches would those be? We generally don't twiddle global CPU features post 
bootup - we pick a model on bootup and go with that.

I'd really like to see code (prototype patches are OK - or the person doing it can 
send it to me privately as well if it's not production quality or public yet), or 
some careful description of the features involved.

Thanks,

	Ingo

