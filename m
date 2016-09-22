Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160921185824.18980-3-khuey@kylehuey.com>
References: <20160921185824.18980-1-khuey@kylehuey.com> <20160921185824.18980-3-khuey@kylehuey.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 22 Sep 2016 15:17:41 -0700
Message-ID: <CALCETrWtAgcUpvGkk=-xPD4of9mjMZKCm-BtzA-YU9iFCCuRjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] x86/arch_prctl/64 Rename do_arch_prctl to do_arch_prctl_64
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Len Brown <len.brown@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Sep 21, 2016 at 11:58 AM, Kyle Huey <me@kylehuey.com> wrote:
> In order to introduce new arch_prctls that are not 64 bit only, rename the
> existing 64 bit implementation to do_arch_prctl_64. Also rename the second
> argument to arch_prctl, which will no longer always be an address.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

