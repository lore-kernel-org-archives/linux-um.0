Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170320081628.18952-2-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-2-khuey@kylehuey.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 27 Jul 2018 10:18:47 -0700
Message-ID: <CALMp9eR-g7-vv8vcTZbf0jeoH=5wNfnwjOT-gW-4gPFDsrLBJg@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] x86/msr: Rename MISC_FEATURE_ENABLES to MISC_FEATURES_ENABLES
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Mar 20, 2017 at 1:16 AM, Kyle Huey <me@kylehuey.com> wrote:
> This matches the only public Intel documentation of this MSR, in the
> "Virtualization Technology FlexMigration Application Note"
> (preserved at https://bugzilla.kernel.org/attachment.cgi?id=243991)
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>

The old spelling matched volume 4 of the SDM, Table 2-43. "Selected
MSRs Supported by Intel Xeon Phi Processors with
DisplayFamily_DisplayModel Signatures 06_57H and 06_85H."

