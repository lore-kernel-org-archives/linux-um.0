Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: Allow building and running on older hosts
References: <20170525183627.9375-1-f.fainelli@gmail.com>
 <B6DC63CC-D5A9-4A56-9832-DD6BD1720CBC@m3y3r.de>
 <82371937-3efc-06e7-8394-2acbb8d38d3a@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <39e78e3c-553a-a8a6-ffc4-9e6c0098b78c@nod.at>
Date: Fri, 26 May 2017 00:34:31 +0200
MIME-Version: 1.0
In-Reply-To: <82371937-3efc-06e7-8394-2acbb8d38d3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org, elicooper@gmx.com, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thomas, Florian,

Am 26.05.2017 um 00:28 schrieb Florian Fainelli:
> On 05/25/2017 12:51 PM, Thomas Meyer wrote:
>>
>>> Am 25.05.2017 um 20:36 schrieb Florian Fainelli <f.fainelli@gmail.com>:
>>>
>>> Commit a78ff1112263 ("um: add extended processor state save/restore
>>> support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
>>> YMM registers") forced the use of the x86 FP _xstate and
>>> PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
>>> build UML nor run it anymore with these two commits applied because we
>>> don't have definitions for struct _xstate nor these two ptrace requests.
>>
>> Btw. what soy you mean with older host? I need to revert two commits to make an UML kernel work again on a Fedora 25 installation.
> 
> This is centos 6.9, so kernel 2.6.32 and glibc 2.12, this neither has
> xstate nor PTRACE_GETREGSET/SETREGSET, hence this patch.

Commits a78ff1112263 and b6024b21fec8 are broken.
You see two different issues.
Eli, please have a look too.

Thanks,
//richard

