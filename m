Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1cn03u-0006qu-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:45:14 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cn03s-0002GJ-CA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:45:14 +0000
References: <20170312093820.12044-1-vegard.nossum@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <bc946709-df33-5c5b-5af6-d889f25087ce@nod.at>
Date: Sun, 12 Mar 2017 10:45:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170312093820.12044-1-vegard.nossum@oracle.com>
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
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Vegard,

Am 12.03.2017 um 10:38 schrieb Vegard Nossum:
> Without KERN_CONT, the symbol will appear on a new line, making stack
> traces completely unreadable:
> 
>     Call Trace:
>      [<6008e891>] ?
>     printk+0x0/0x94
>      [<6001cce6>]
>     show_stack+0xfe/0x15b
>      [<600666ec>] ?
>     dump_stack_print_info+0xe1/0xea
>      [<6008e891>] ?
>     printk+0x0/0x94
>      [<6023e826>] ?
>     bust_spinlocks+0x0/0x4f
>      [<602343b8>]
>     dump_stack+0x2a/0x2c
>      [<6008e662>]
>     panic+0x170/0x31e
>      [<6008e4f2>] ?
>     panic+0x0/0x31e
> 
> This makes it readable again:
> 
>     Call Trace:
>      [<6008e891>] ? printk+0x0/0x94
>      [<6001cce6>] show_stack+0xfe/0x15b
>      [<600666ec>] ? dump_stack_print_info+0xe1/0xea
>      [<6008e891>] ? printk+0x0/0x94
>      [<6023e826>] ? bust_spinlocks+0x0/0x4f
>      [<602343b8>] dump_stack+0x2a/0x2c
>      [<6008e662>] panic+0x170/0x31e
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  arch/um/kernel/sysrq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index a76295f7ede9..edf1f80123e7 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -22,7 +22,7 @@ static void _print_addr(void *data, unsigned long address, int reliable)
>  {
>  	pr_info(" [<%08lx>]", address);
>  	pr_cont(" %s", reliable ? "" : "? ");
> -	print_symbol("%s", address);
> +	print_symbol(KERN_CONT "%s", address);
>  	pr_cont("\n");
>  }
> 

I think it is better to fix the root of the problem by using a single printk.
i.e.

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index aa1b56f5ac68..18eddf677ec6 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -17,10 +17,8 @@

 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-       pr_info(" [<%08lx>]", address);
-       pr_cont(" %s", reliable ? "" : "? ");
-       print_symbol("%s", address);
-       pr_cont("\n");
+       pr_info(" [<%08lx>] %s%pB\n", address, reliable ? "" : "? ",
+               (void *)address);
 }

Thanks,
//richard

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

