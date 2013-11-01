Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VcAw7-0004am-Tt
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Nov 2013 09:22:36 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VcAw4-0003JL-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Nov 2013 09:22:35 +0000
Message-ID: <527372C4.2080706@nod.at>
Date: Fri, 01 Nov 2013 10:22:12 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20131029190604.GA21820@longonot.mountain>
In-Reply-To: <20131029190604.GA21820@longonot.mountain>
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
Subject: Re: [uml-devel] [patch] uml: check length in exitcode_proc_write()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Fabian Yamaguchi <fabs@goesec.de>, security@kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, Nico Golde <nico@ngolde.de>

Am 29.10.2013 20:06, schrieb Dan Carpenter:
> We don't cap the size of buffer from the user so we could write past
> the end of the array here.  Only root can write to this file.
> 
> Reported-by: Nico Golde <nico@ngolde.de>
> Reported-by: Fabian Yamaguchi <fabs@goesec.de>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks everyone!
Patch applied and an it's way to Linus' tree.

Thanks,
//richard

> diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
> index 829df49..41ebbfe 100644
> --- a/arch/um/kernel/exitcode.c
> +++ b/arch/um/kernel/exitcode.c
> @@ -40,9 +40,11 @@ static ssize_t exitcode_proc_write(struct file *file,
>  		const char __user *buffer, size_t count, loff_t *pos)
>  {
>  	char *end, buf[sizeof("nnnnn\0")];
> +	size_t size;
>  	int tmp;
>  
> -	if (copy_from_user(buf, buffer, count))
> +	size = min(count, sizeof(buf));
> +	if (copy_from_user(buf, buffer, size))
>  		return -EFAULT;
>  
>  	tmp = simple_strtol(buf, &end, 0);
> 


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

