Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 14:07:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v14 0/9] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for
 controlling the CPUID instruction
In-Reply-To: <20170208080917.24320-1-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1702101405570.4036@nanos>
References: <20170208080917.24320-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 8 Feb 2017, Kyle Huey wrote:

> rr (http://rr-project.org/), a userspace record-and-replay reverse-
> execution debugger, would like to trap and emulate the CPUID instruction.
> This would allow us to a) mask away certain hardware features that rr does
> not support (e.g. RDRAND) and b) enable trace portability across machines
> by providing constant results.
> 
> Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
> CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
> ARCH_GET_CPUID and ARCH_SET_CPUID.
> 
> Since v13:
> All: rebased on top of tglx's __switch_to_xtra patches
> (https://lkml.org/lkml/2016/12/15/432)

That doesn't help because that patchset is stale and it has unresolved
comments. I don't know when I have cycles to revisit it, but if you want to
have a try feel free to do so.

Thanks,

	tglx

