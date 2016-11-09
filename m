Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 10:47:05 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v10 1/7] x86/arch_prctl/64: Use SYSCALL_DEFINE2 to define
 sys_arch_prctl
Message-ID: <20161109094705.wvtyzpz7j7mqcz2x@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-2-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161108183956.4521-2-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 08, 2016 at 10:39:50AM -0800, Kyle Huey wrote:

<--- Add commit message here.

> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/x86/kernel/process_64.c | 3 ++-
>  arch/x86/um/syscalls_64.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

...

>  void arch_switch_to(struct task_struct *to)
>  {
>  	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
>  		return;
> 
> base-commit: e3a00f68e426df24a5fb98956a1bd1b23943aa1e

This looks like some tracking thing. It gets ignored by tools though...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

