Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3] um: Fix build error and kconfig for i386
References: <1450959131-5113-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5692BCFE.10804@nod.at>
Date: Sun, 10 Jan 2016 21:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <1450959131-5113-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Josh Triplett <josh@joshtriplett.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 24.12.2015 um 13:12 schrieb Mickaël Salaün:
> Fix build error by generating elfcore.o only when ELF_CORE (depending on
> COREDUMP) is selected:
> 
> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
> (.text+0x3e62): undefined reference to `dump_emit'
> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
> (.text+0x3eef): undefined reference to `dump_emit'
> 
> Fixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options behind EMBEDDED and EXPERT")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Applied!

Thanks,
//richard

