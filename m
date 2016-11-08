Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Nov 2016 18:53:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v9 7/7] KVM: x86: virtualize cpuid faulting
In-Reply-To: <CAP045ApKtyuWUtOpiLPnvKqwBBugm6tN+CzPLgEWgaqSx0+BeQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611081851380.3501@nanos>
References: <20161106205742.4042-1-khuey@kylehuey.com> <20161106205742.4042-8-khuey@kylehuey.com> <CALzav=diEGujPVrkDmJvsJHHPNAXymhBK=4WVFbfv+TdNmQQ4g@mail.gmail.com> <CAP045ApKtyuWUtOpiLPnvKqwBBugm6tN+CzPLgEWgaqSx0+BeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: David Matlack <dmatlack@google.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 8 Nov 2016, Kyle Huey wrote:
> > It will simplify the MSR get/set code, and make it easier to plumb
> > support for new bits in these MSRs.
> 
> I'm inclined to do this for MSR_PLATFORM_INFO but not
> MSR_MISC_FEATURES_ENABLES.  The former actually has other bits, and
> isn't used outside the msr handling code (yet, anyways).
> MSR_MISC_FEATURES_ENABLES doesn't have any other bits (it's actually
> not documented by Intel at all outside of that virtualization paper)
> and after masking bits in cpuid.c or adding a helper function the
> complexity would be a wash at best.

The feature MSR is also used for enabling ring3 MWAIT, which is obviously
not documented either. So there is more stuff coming along....

Thanks,

	tglx


