Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Jun 2016 12:51:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-12-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
	<1465506124-21866-12-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160610125158.16dd5497@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu,  9 Jun 2016 14:02:01 -0700
Kees Cook <keescook@chromium.org> wrote:

> Close the hole where ptrace can change a syscall out from under seccomp.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/ptrace.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

If the change in semantics in regard to the audit of skipped system calls
is acceptable, the modified s390 arch code is ok.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


