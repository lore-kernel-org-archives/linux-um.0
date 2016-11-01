Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Nov 2016 10:26:06 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <273805880.9973234.1478010366977.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161101013749.4003-8-khuey@kylehuey.com>
References: <20161101013749.4003-1-khuey@kylehuey.com> <20161101013749.4003-8-khuey@kylehuey.com>
Subject: Re: [PATCH v8 7/7] KVM: x86: virtualize cpuid faulting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


> +	vcpu->arch.cpuid_fault = false;

This should be conditional on "if (!init_event)".  Most MSRs are untouched
on an INIT IPI.

Otherwise looks good.  The patch is independent of the rest, so I would
prefer to take it through the KVM tree.

Thanks,

Paolo

>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  	vcpu->arch.apf.msr_val = 0;
>  	vcpu->arch.st.msr_val = 0;
>  
>  	kvmclock_reset(vcpu);
>  
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	kvm_async_pf_hash_reset(vcpu);
> --
> 2.10.2
> 
> 

