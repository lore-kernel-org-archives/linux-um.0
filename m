Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH v11 7/7] KVM: x86: virtualize cpuid faulting
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20161110234055.8654-8-khuey@kylehuey.com>
Date: Fri, 11 Nov 2016 12:54:46 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <26413C89-E639-4834-A600-C4B6679162F2@gmail.com>
References: <20161110234055.8654-1-khuey@kylehuey.com>
 <20161110234055.8654-8-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, KVM <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


> On Nov 10, 2016, at 3:40 PM, Kyle Huey <me@kylehuey.com> wrote:
>=20
> Hardware support for faulting on the cpuid instruction is not required =
to
> emulate it, because cpuid triggers a VM exit anyways. KVM handles the =
relevant
> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
> kvm_require_cpl is even kind enough to inject the GP fault for us.

I think that for consistency you should also revise em_cpuid() of KVM
instruction emulator. Otherwise it may be a potential security
hazard (as far fetched as it currently seems).

Nadav



