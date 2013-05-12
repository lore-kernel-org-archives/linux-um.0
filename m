Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1305122247320.5463@ayla.of.borg>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg>
	<alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
	<alpine.DEB.2.00.1305122247320.5463@ayla.of.borg>
Date: Sun, 12 May 2013 23:17:28 +0200
Message-ID: <CAFLxGvzA5nzpQjOKWgz0nBKG2s3gPspted-25uduqkr7_ySj6A@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: Build regressions/improvements in v3.10-rc1 (um)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Geert,

On Sun, May 12, 2013 at 10:47 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, 12 May 2013, Geert Uytterhoeven wrote:
>> However, the full list of errors isn't that unmanageable, so I'm following
>> up with a digested list...
>
> arch/um/drivers/cow_user.c:216: error: implicit declaration of function 'htobe32': 1 errors in 1 logs
> arch/um/drivers/cow_user.c:249: error: implicit declaration of function 'htobe64': 1 errors in 1 logs
> arch/um/drivers/cow_user.c:303: error: implicit declaration of function 'be32toh': 1 errors in 1 logs
> arch/um/drivers/cow_user.c:330: error: implicit declaration of function 'be64toh': 1 errors in 1 logs
> arch/um/os-Linux/skas/process.c:321: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/skas/process.c:321: error: (Each undeclared identifier is reported only once: 1 errors in 1 logs
> arch/um/os-Linux/skas/process.c:321: error: for each function it appears in.): 1 errors in 1 logs
> arch/um/os-Linux/skas/process.c:412: error: 'PTRACE_GETSIGINFO' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/skas/process.c:560: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:245: error: 'PTRACE_SETOPTIONS' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:245: error: (Each undeclared identifier is reported only once: 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:245: error: for each function it appears in.): 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:246: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:303: error: 'PTRACE_SETOPTIONS' undeclared (first use in this function): 1 errors in 1 logs
> arch/um/os-Linux/start_up.c:304: error: 'PTRACE_O_TRACESYSGOOD' undeclared (first use in this function): 1 errors in 1 logs
>         v3.10-rc1/um-i386/um-defconfig
>         Old host environment on kissb?

This really looks like a host environment issue.
PTRACE_O_TRACESYSGOOD for example is defined in /usr/include/linux/ptrace.h

--
Thanks,
//richard

