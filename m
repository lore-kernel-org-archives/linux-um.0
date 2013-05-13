MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <38896893-83c7-4eb4-848a-bb35663d945b@email.android.com>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg>
	<alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
	<alpine.DEB.2.00.1305122247320.5463@ayla.of.borg>
	<CAFLxGvzA5nzpQjOKWgz0nBKG2s3gPspted-25uduqkr7_ySj6A@mail.gmail.com>
	<CAMuHMdWt0i6Q+i9Qh+tMs910a388NoddhHmq2LGr50f1=dJPvQ@mail.gmail.com>
	<38896893-83c7-4eb4-848a-bb35663d945b@email.android.com>
Date: Mon, 13 May 2013 12:02:14 +0200
Message-ID: <CAMuHMdUyDS-knihSJq68HXWbqRR0sAnfopgtwWdeNJbnOqUotQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.10-rc1 (um)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Michael Ellerman <michael@ellerman.id.au>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Development <linux-kernel@vger.kernel.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 13, 2013 at 11:54 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
>>> This really looks like a host environment issue.
>>> PTRACE_O_TRACESYSGOOD for example is defined in
>>/usr/include/linux/ptrace.h

Actually these are in both /usr/include/sys/ptrace.h and
/usr/include/linux/ptrace.h on
my system.

>>Yep, just like e.g. htobe32().

/usr/include/endian.h

>>Michael, Stephen: Any chance this can be fixed?
>
> Possibly. We're cross compiling these on powerpc so perhaps we need to update the cross compiler.

Perhaps just the cross C library? On Ubuntu 10.04, both
/usr/include/endian.h and
/usr/include/sys/ptrace.h are provided by libc6-dev.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

