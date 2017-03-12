Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1cn06e-0001k7-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:48:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cn06c-0005L5-9w
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:48:04 +0000
References: <20170312093820.12044-1-vegard.nossum@oracle.com>
	<bc946709-df33-5c5b-5af6-d889f25087ce@nod.at>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <005a0edf-6d5e-e9c0-6f93-3d08a41cb24a@oracle.com>
Date: Sun, 12 Mar 2017 10:47:53 +0100
MIME-Version: 1.0
In-Reply-To: <bc946709-df33-5c5b-5af6-d889f25087ce@nod.at>
Subject: Re: [uml-devel] [PATCH] um: use KERN_CONT in stack dump
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 12/03/2017 10:45, Richard Weinberger wrote:
> Am 12.03.2017 um 10:38 schrieb Vegard Nossum:
>> Without KERN_CONT, the symbol will appear on a new line, making stack
>> traces completely unreadable:
[snip]
> I think it is better to fix the root of the problem by using a single printk.
> i.e.
>
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index aa1b56f5ac68..18eddf677ec6 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -17,10 +17,8 @@
>
>  static void _print_addr(void *data, unsigned long address, int reliable)
>  {
> -       pr_info(" [<%08lx>]", address);
> -       pr_cont(" %s", reliable ? "" : "? ");
> -       print_symbol("%s", address);
> -       pr_cont("\n");
> +       pr_info(" [<%08lx>] %s%pB\n", address, reliable ? "" : "? ",
> +               (void *)address);
>  }

Your patch is better.

Tested-by: Vegard Nossum <vegard.nossum@oracle.com>

Thanks,


Vegard

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

