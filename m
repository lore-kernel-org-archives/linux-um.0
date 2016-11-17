Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Nov 2016 17:51:54 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v12 5/7] x86/cpufeature: Detect CPUID faulting support
Message-ID: <20161117165154.knskynwyjpzqglnd@pd.tnic>
References: <20161117020610.5302-1-khuey@kylehuey.com>
 <20161117020610.5302-6-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161117020610.5302-6-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 16, 2016 at 06:06:08PM -0800, Kyle Huey wrote:
> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. This will allow a ptracer to emulate the CPUID
> instruction.
> 
> Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
> documented in detail in Section 2.3.2 of
> https://bugzilla.kernel.org/attachment.cgi?id=243991
> 
> Detect support for this feature and expose it as X86_FEATURE_CPUID_FAULT.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/include/asm/msr-index.h   |  2 ++
>  arch/x86/kernel/cpu/intel.c        | 12 ++++++++++++
>  3 files changed, 15 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

