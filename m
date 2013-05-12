Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 12 May 2013 22:47:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1305122247320.5463@ayla.of.borg>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg> <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: Build regressions/improvements in v3.10-rc1 (um)
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 12 May 2013, Geert Uytterhoeven wrote:
> However, the full list of errors isn't that unmanageable, so I'm following
> up with a digested list...

arch/um/drivers/cow_user.c:216: error: implicit declaration of function 'htobe32': 1 errors in 1 logs
arch/um/drivers/cow_user.c:249: error: implicit declaration of function 'htobe64': 1 errors in 1 logs
arch/um/drivers/cow_user.c:303: error: implicit declaration of function 'be32toh': 1 errors in 1 logs
arch/um/drivers/cow_user.c:330: error: implicit declaration of function 'be64toh': 1 errors in 1 logs
arch/um/os-Linux/skas/process.c:321: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/skas/process.c:321: error: (Each undeclared identifier is reported only once: 1 errors in 1 logs
arch/um/os-Linux/skas/process.c:321: error: for each function it appears in.): 1 errors in 1 logs
arch/um/os-Linux/skas/process.c:412: error: 'PTRACE_GETSIGINFO' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/skas/process.c:560: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/start_up.c:245: error: 'PTRACE_SETOPTIONS' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/start_up.c:245: error: (Each undeclared identifier is reported only once: 1 errors in 1 logs
arch/um/os-Linux/start_up.c:245: error: for each function it appears in.): 1 errors in 1 logs
arch/um/os-Linux/start_up.c:246: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/start_up.c:303: error: 'PTRACE_SETOPTIONS' undeclared (first use in this function): 1 errors in 1 logs
arch/um/os-Linux/start_up.c:304: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
	v3.10-rc1/um-i386/um-defconfig
	Old host environment on kissb?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
