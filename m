Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Mar 2017 16:00:16 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v16 08/10] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
In-Reply-To: <20170320081628.18952-9-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1703201558450.3599@nanos>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-9-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 20 Mar 2017, Kyle Huey wrote:
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -6,8 +6,17 @@
>  #define ARCH_GET_FS 0x1003
>  #define ARCH_GET_GS 0x1004
>  
> +#define ARCH_GET_CPUID 0x1005
> +#define ARCH_SET_CPUID 0x1006
> +
>  #define ARCH_MAP_VDSO_X32	0x2001
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>  
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +# define ARCH_MAP_VDSO_X32	0x2001
> +# define ARCH_MAP_VDSO_32	0x2002
> +# define ARCH_MAP_VDSO_64	0x2003
> +#endif

That hunk is bogus in two aspects:
     - It's just a copy of the above wrapped in a ifdef
     
     - The ifdef is broken, because the UAPI headers do not know about
       that.

I dropped it.

