Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1d61IF-0007kO-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2017 20:54:39 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d61IE-0008QD-VF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2017 20:54:39 +0000
Received: by mail-io0-f194.google.com with SMTP id x86so38271418ioe.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 May 2017 13:54:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170331224157.12922-1-richard@nod.at>
References: <20170331224157.12922-1-richard@nod.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 3 May 2017 22:54:33 +0200
Message-ID: <CAFLxGvxyHYyU8BKb8O3fwd9143VQHLQ-B=+jKc8-2mJGJOGB-Q@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Fix PTRACE_POKEUSER on x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On Sat, Apr 1, 2017 at 12:41 AM, Richard Weinberger <richard@nod.at> wrote:
> This is broken since ever but sadly nobody noticed.
> Recent versions of GDB set DR_CONTROL unconditionally and
> UML dies due to a heap corruption. It turns out that
> the PTRACE_POKEUSER was copy&pasted from i386 and assumes
> that addresses are 4 bytes long.
>
> Fix that by using 8 as address size in the calculation.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: jie cao <cj3054@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/um/ptrace_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
> index a5c9910d234f..09a085bde0d4 100644
> --- a/arch/x86/um/ptrace_64.c
> +++ b/arch/x86/um/ptrace_64.c
> @@ -125,7 +125,7 @@ int poke_user(struct task_struct *child, long addr, long data)
>         else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
>                 (addr <= offsetof(struct user, u_debugreg[7]))) {
>                 addr -= offsetof(struct user, u_debugreg[0]);
> -               addr = addr >> 2;
> +               addr = addr >> 3;
>                 if ((addr == 4) || (addr == 5))
>                         return -EIO;
>                 child->thread.arch.debugregs[addr] = data;

Applied.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

