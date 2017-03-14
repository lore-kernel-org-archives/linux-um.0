Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-7-khuey@kylehuey.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <30f2ec3e-d0c8-8dd2-837f-3380237d843c@zytor.com>
Date: Tue, 14 Mar 2017 12:01:27 -0700
MIME-Version: 1.0
In-Reply-To: <20161108183956.4521-7-khuey@kylehuey.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 11/08/16 10:39, Kyle Huey wrote:
>  	}
>  
> +	if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
> +	    test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
> +		set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
> +	}
> +
>  	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
>  	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
>  		/* prev and next are different */
>  		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
>  			hard_disable_TSC();
>  		else
>  			hard_enable_TSC();
>  	}

I'm unhappy about this part: we already do two XORs on these after bit
extraction, which is quite inefficient; and at least theoretically we
could be indirecting though the ->stack pointer for every one if gcc
can't tell it won't have changed (we really need to get thread_info
moved into the task_struct allocation and away from the kernel stack,
especially since on x86 the pointer is the same size as the vestigial
structure it points to.)

It would be so much saner to do one xor and then go onto a common slow path:

	struct thread_info *prev_ti = task_thread_info(prev_p);
	struct thread_info *next_ti = task_thread_info(next_p);

	tif_flipped = prev_ti->flags ^ next_ti->flags;

	if (unlikely(tif_flipped &
		(_TIF_BLOCKSTEP | _TIF_NOTSC | _TIF_NOCPUID))) {
		if (tif_flipped & _TIF_BLOCKSTEP) {
			...
		}
		if (tif_flipped & _TIF_NOTSC) {
			...
		}
		if (tif_flipped & _TIF_NOCPUID) {
			...
		}
	}

Then we can also replace test_tsk_thread_flag() with
test_ti_thread_flag() in other places in this function.

	-hpa



