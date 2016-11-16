Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Nov 2016 15:42:15 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1514461290.13216247.1479328935760.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAP045AqG5f5pJLYVVnFZfrFv8h8ZzpcD=bkS+tJrVWE_vX48Qg@mail.gmail.com>
References: <20161110234055.8654-1-khuey@kylehuey.com> <20161110234055.8654-8-khuey@kylehuey.com> <26413C89-E639-4834-A600-C4B6679162F2@gmail.com> <CAP045AqG5f5pJLYVVnFZfrFv8h8ZzpcD=bkS+tJrVWE_vX48Qg@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] KVM: x86: virtualize cpuid faulting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Nadav Amit <nadav.amit@gmail.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, LKML <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KVM <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> On Fri, Nov 11, 2016 at 12:54 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> >> On Nov 10, 2016, at 3:40 PM, Kyle Huey <me@kylehuey.com> wrote:
> >>
> >> Hardware support for faulting on the cpuid instruction is not required to
> >> emulate it, because cpuid triggers a VM exit anyways. KVM handles the
> >> relevant
> >> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
> >> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
> >> kvm_require_cpl is even kind enough to inject the GP fault for us.
> >
> > I think that for consistency you should also revise em_cpuid() of KVM
> > instruction emulator. Otherwise it may be a potential security
> > hazard (as far fetched as it currently seems).
> 
> Hmm, ok.  Do you know how I can test this code path?

Try this patch (untested!)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5382b82462fc..06d940a7c9fa 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5868,8 +5868,7 @@ static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 
 static int handle_cpuid(struct kvm_vcpu *vcpu)
 {
-	kvm_emulate_cpuid(vcpu);
-	return 1;
+	return emulate_instruction(vcpu, 0) == EMULATE_DONE;
 }
 
 static int handle_rdmsr(struct kvm_vcpu *vcpu)

Paolo

