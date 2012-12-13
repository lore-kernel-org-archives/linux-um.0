Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50CA2194.40103@zytor.com>
Date: Thu, 13 Dec 2012 10:42:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <cover.1355335227.git.joe@perches.com> <054f8a88fe46ae0b4c2669d0e155d84c11b66115.1355335228.git.joe@perches.com> <20121212210959.GH8760@liondog.tnic> <1355347803.8538.16.camel@joe-AO722> <3908561D78D1C84285E8C5FCA982C28F1C969495@ORSMSX108.amr.corp.intel.com> <1355351039.27571.2.camel@joe-AO722> <20121212224550.GJ8760@liondog.tnic> <1355422990.13796.9.camel@joe-AO722> <20121213183659.GC31485@liondog.tnic>
In-Reply-To: <20121213183659.GC31485@liondog.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 16/26] x86: Convert print_symbol to %pSR
To: Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>, "Luck, Tony" <tony.luck@intel.com>, Jiri Kosina <trivial@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 12/13/2012 10:37 AM, Borislav Petkov wrote:
>>
>> If appropriate, the code could be changed to
>>
>> 	(void *)(unsigned long)m->ip
> 
> Can we explicitly cast it to what it is so that we can be explicit as to
> what we're casting it? IOW:
> 
> 	(void *)(__u64)m->ip;
> 
> Does that even work on 32bit?
> 
> Also, does the compiler bitch about this useless cast when building with
> W=123?
> 

Uh... no.

The point is that (void *)(unsigned long) casts it to an integer of
pointer size -- in userspace you would to (void *)(size_t) or (void
*)(uintptr_t) -- so that the compiler knows "I meant to do that."

	-hpa


