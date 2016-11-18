Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Nov 2016 09:16:44 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v12 2/7] x86/arch_prctl/64: Rename do_arch_prctl to
 do_arch_prctl_64
Message-ID: <20161118081644.GD15912@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com>
 <20161117020610.5302-3-khuey@kylehuey.com>
 <20161118072723.GA15912@gmail.com>
 <alpine.DEB.2.20.1611180827240.3640@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611180827240.3640@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 18 Nov 2016, Ingo Molnar wrote:
> 
> > 
> > * Kyle Huey <me@kylehuey.com> wrote:
> > 
> > > In order to introduce new arch_prctls that are not 64 bit only, rename the
> > > existing 64 bit implementation to do_arch_prctl_64(). Also rename the second
> > > argument to arch_prctl(), which will no longer always be an address.
> > 
> > >  #ifdef CONFIG_X86_64
> > >  void entry_SYSCALL_64(void);
> > > +long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
> > >  #endif
> > 
> > Could you please also rename the weirdly named 'code' argument to 'option',
> > to be in line with the existing sys_prctl() interface nomenclature?
> 
> I'll fix that up when picking up the series. No need for another iteration, ok?

I think the main patch needs a bit of conceptual work still:

 - simpler ABI
 - better exec() behavior
 - simpler, better, faster implementation for the MSR writes

... see the mail I just wrote.

Thanks,

	Ingo

