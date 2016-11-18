Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161118081444.GC15912@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com> <20161117020610.5302-7-khuey@kylehuey.com>
 <20161118081444.GC15912@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 18 Nov 2016 09:32:46 -0800
Message-ID: <CALCETrX5SZh7=p1wk3yo8=vdg=veJmLwexMFGE=86bK1G6HkGQ@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Dmitry Safonov <dsafonov@virtuozzo.com>, Nadav Amit <nadav.amit@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, X86 ML <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Paolo Bonzini <pbonzini@redhat.com>, Kyle Huey <me@kylehuey.com>, Dave Hansen <dave.hansen@linux.intel.com>, Robert O'Callahan <robert@ocallahan.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Shuah Khan <shuah@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Matlack <dmatlack@google.com>, Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>, Richard Weinberger <richard@nod.at>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Nov 18, 2016 12:14 AM, "Ingo Molnar" <mingo@kernel.org> wrote:
>
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
> > Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> > When enabled, the processor will fault on attempts to execute the CPUID
> > instruction with CPL>0. Exposing this feature to userspace will allow a
> > ptracer to trap and emulate the CPUID instruction.
> >
> > When supported, this feature is controlled by toggling bit 0 of
> > MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
> > https://bugzilla.kernel.org/attachment.cgi?id=243991
> >
> > Implement a new pair of arch_prctls, available on both x86-32 and x86-64.
> >
> > ARCH_GET_CPUID: Returns the current CPUID faulting state, either
> >   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. arg2 must be 0.
> >
> > ARCH_SET_CPUID: Set the CPUID faulting state to arg2, which must be either
> >   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. Returns EINVAL if arg2 is
> >   another value or CPUID faulting is not supported on this system.
>
> So the interface is:
>
> > +#define ARCH_GET_CPUID 0x1005
> > +#define ARCH_SET_CPUID 0x1006
> > +#define ARCH_CPUID_ENABLE 1
> > +#define ARCH_CPUID_SIGSEGV 2
>
> Which maps to:
>
>    prctl(ARCH_SET_CPUID, 0); /* -EINVAL */
>    prctl(ARCH_SET_CPUID, 1); /* enable CPUID [i.e. make it work without faulting] */
>    prctl(ARCH_SET_CPUID, 2); /* disable CPUID [i.e. make it fault] */
>
>    ret = prctl(ARCH_GET_CPUID, 0); /* return current state: 1==on, 2==off */
>
> This is a very broken interface that makes very little sense.
>
> It would be much better to use a more natural interface where 1/0 means on/off and
> where ARCH_GET_CPUID returns the current natural state:
>
>    prctl(ARCH_SET_CPUID, 0); /* disable CPUID [i.e. make it fault] */
>    prctl(ARCH_SET_CPUID, 1); /* enable CPUID [i.e. make it work without faulting] */
>
>    ret = prctl(ARCH_GET_CPUID); /* 1==enabled, 0==disabled */
>
> See how natural it is? The use of the ARCH_CPUID_SIGSEGV/ENABLED symbols can be
> avoided altogether. This will cut down on some of the ugliness in the kernel code
> as well - and clean up the argument name as well: instead of naming it 'int arg2'
> it can be named the more natural 'int cpuid_enabled'.
>
> > The state of the CPUID faulting flag is propagated across forks, but reset
> > upon exec.
>
> I don't think this is the natural API for propagating settings across exec().
> We should reset the flag on exec() only if security considerations require it -
> i.e. like perf events are cleared.
>
> If binaries that assume a working CPUID are exec()-ed then CPUID can be enabled
> explicitly.

I disagree.  I'd rather not create more weird state that's carried
across exec.  We already have the iopl screwup IIRC.  I think exec
should stay as close to just working as possible.

Also, if we keep it disabled across exec, we have to come up with a
usable API that respects security considerations.  We could use
no_new_privs or we could auto-clear it on privilege changes.  The
former is IMO overcomplicated and the latter is really ugly especially
when LSMs are involved.

>
> Clearing it automatically loses the ability of a pure no-CPUID environment to
> exec() a CPUID-safe binary.

If we really want this, let's wait until a user appears and add a
"sticky" no-CPUID mode that requires no_new_privs to enable.

--Andy

