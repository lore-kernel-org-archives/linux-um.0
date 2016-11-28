Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 28 Nov 2016 15:06:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v13 6/8] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
In-Reply-To: <20161128030521.4423-7-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1611281437130.3512@nanos>
References: <20161128030521.4423-1-khuey@kylehuey.com> <20161128030521.4423-7-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 27 Nov 2016, Kyle Huey wrote:
> +DEFINE_PER_CPU(u64, msr_misc_features_shadow);
> +
> +static void set_cpuid_faulting(bool on)
> +{
> +	u64 msrval;
> +
> +	DEBUG_LOCKS_WARN_ON(!irqs_disabled());

The arch_prctl code path does not have interrupts disabled and there is no
reason why it should have.

Thanks,

	tglx

