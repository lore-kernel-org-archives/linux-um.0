Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Nov 2016 20:06:28 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 5/7] x86/cpufeature: Detect CPUID faulting support
In-Reply-To: <20161108183956.4521-6-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1611082002160.3501@nanos>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-6-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 8 Nov 2016, Kyle Huey wrote:

> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. This will allow a ptracer to emulate the CPUID
> instruction.
> 
> Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
> documented in detail in Section 2.3.2 of
> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf

Can you please stick that document into the kernel bugzilla, as it's going
to be on a different place before this gets merged into Linus tree?

See: http://lkml.kernel.org/r/1478631281-5061-1-git-send-email-kan.liang@intel.com

> +	static const struct msr_bit msr_bits[] = {
> +		{ X86_FEATURE_CPUID_FAULT,	MSR_PLATFORM_INFO, 31 },

Can you please make that PLATINFO_CPUID_FAULT_BIT instead of 31?

Thanks,

	tglx

