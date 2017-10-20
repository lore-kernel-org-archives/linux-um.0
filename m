Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Oct 2017 10:53:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v16 09/10] x86/arch_prctl: Selftest for
 ARCH_[GET|SET]_CPUID
In-Reply-To: <CAP045AoC+z73gkAShdkxQyY0FV0m+eW+sLH73Rvjq7wjwX2ytA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710201050290.1882@nanos>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-10-khuey@kylehuey.com> <CANRm+Cys9jhHr6uWkUkUbAqFPQid1AkERG2-j1qt4-VNTkqjQg@mail.gmail.com> <CAP045AoC+z73gkAShdkxQyY0FV0m+eW+sLH73Rvjq7wjwX2ytA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 10 Oct 2017, Kyle Huey wrote:

> On Tue, Oct 10, 2017 at 8:35 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
> > Hi Kyle,
> > 2017-03-20 16:16 GMT+08:00 Kyle Huey <me@kylehuey.com>:
> >> Test disabling and reenabling the cpuid instruction via the new arch_prctl
> >> ARCH_SET_CPUID, retrieving the current state via ARCH_GET_CPUID, and the
> >> expected behaviors across fork() and exec().
> >>
> >> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> >> ---
> >>  tools/testing/selftests/x86/Makefile      |   2 +-
> >>  tools/testing/selftests/x86/cpuid_fault.c | 251 ++++++++++++++++++++++++++++++
> >
> > I'm not sure why this commit is not merged to upstream. I test
> > 4.14-rc3 w/ this testcase on a haswell client, however I encounter the
> > below splat, any idea?
> 
> Thanks for pointing out that this never got merged.  That's quite
> disappointing, especially after reviewers insisted I write this test.

Sorry about that. I expected it to be picked up by Shuah and I assumed the
same happend the other way round.

Can you please resubmit?

Thanks,

	tglx



