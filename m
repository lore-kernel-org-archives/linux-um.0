Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Nov 2016 12:33:56 -0600 (MDT)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v8 7/7] KVM: x86: virtualize cpuid faulting
In-Reply-To: <273805880.9973234.1478010366977.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.DEB.2.20.1611011233100.14687@nanos>
References: <20161101013749.4003-1-khuey@kylehuey.com> <20161101013749.4003-8-khuey@kylehuey.com> <273805880.9973234.1478010366977.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 1 Nov 2016, Paolo Bonzini wrote:

> 
> > +	vcpu->arch.cpuid_fault = false;
> 
> This should be conditional on "if (!init_event)".  Most MSRs are untouched
> on an INIT IPI.
> 
> Otherwise looks good.  The patch is independent of the rest, so I would
> prefer to take it through the KVM tree.
> 

It depends on the FEATURE_ENABLES MSR define, which is part of that series.

Thanks

	tglx

