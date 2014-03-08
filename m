Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WMBz4-0008JT-34
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 07:47:50 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WMBz2-0000uo-L4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 07:47:49 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab3.miniserver.com with esmtps
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WMBxI-00031b-Tm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 07:46:00 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WMByv-0002SF-TH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Mar 2014 07:47:41 +0000
Message-ID: <531ACAFB.5010001@kot-begemot.co.uk>
Date: Sat, 08 Mar 2014 07:47:07 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1394261476-776718-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<1394261476-776718-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1394261476-776718-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] [PATCH 3/3] BUG: PIPE is the wrong IPC for this
 type of inter-thread communication.
To: user-mode-linux-devel@lists.sourceforge.net

This bug has been there as far back as 2.6.x... It is known as
"userspace process sits in Z state", occasional hang, etc. It has been
tagged by maintainers as "unreproducible" for 7 odd years now. I agree -
on stock UML it is difficult to reproduce - it may take half a day to
hit it when running a specially designed test case. You have to improve
network IO to a reasonable performance level for it to come and shine on
a regular basis.

In any case - this fix also provides a considerable performance
improvement on "real life" network apps which need both disk io and
network. There you hit the "pipe is no longer consuming requests"
barrier on a very regular basis.

For example: when wgetting a file and storing it across a 1GBit link
without it I get ~ 340MBit max. With it I can hit line rate.

I have filed it as Debian 741077, the other two are 741076 and 741075.

By the way - this means that the request disposal and handling of failed
requests in the UBD driver is wrong somewhere else. No idea where.

A.


On 08/03/14 06:51, anton.ivanov@kot-begemot.co.uk wrote:
> From: Anton Ivanov <antivano@cisco.com>
>
> For more details see:
>
> http://stackoverflow.com/questions/4624071/pipe-buffer-size-is-4k-or-64k
>
> The observations on that thread have been confirmed by us for UML's
> UBD driver. If you load UML with network IO and do disk IO at the same
> time the UBD IO helper thread fails to process requests fast enough.
>
> In most cases this will lead to a slowdown in disk IO as well as
> inability to execute new processes until the network load goes away.
> In some cases however it will not recover. Example - with our new high
> performance 1G+ network drivers a wget of 1G file from the network
> is a nearly guaranteed crash if it writes out to UBD.
>
> The crashes and the slowdowns are not observed with this patch -
> it switches the IPC to socket which does not have the pipe granularity
> and queue size problems.
>
> This signifies a problem with overall UBD error handling which this
> patch fails to fix. The workaround should be good enough for most
> cases.
>
> Signed-off-by: Anton Ivanov <antivano@cisco.com>
> ---
>  arch/um/drivers/ubd_kern.c |    2 +-
>  arch/um/drivers/ubd_user.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 944453a..c9a5717 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1291,7 +1291,7 @@ static void do_ubd_request(struct request_queue *q)
>  			n = os_write_file(thread_fd, &io_req,
>  					  sizeof(struct io_thread_req *));
>  			if(n != sizeof(struct io_thread_req *)){
> -				if(n != -EAGAIN)
> +				if(!((n == -EAGAIN) || (n == -ENOBUFS)))
>  					printk("write to io thread failed, "
>  					       "errno = %d\n", -n);
>  				else if(list_empty(&dev->restart))
> diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
> index 007b94d..f1f84a4 100644
> --- a/arch/um/drivers/ubd_user.c
> +++ b/arch/um/drivers/ubd_user.c
> @@ -32,7 +32,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
>  {
>  	int pid, fds[2], err;
>  
> -	err = os_pipe(fds, 1, 1);
> +	err = socketpair(AF_UNIX, SOCK_STREAM, 0, (int *) &fds);
>  	if(err < 0){
>  		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
>  		goto out;


-- 
"If you think it's expensive to hire a professional to do the job,
    wait until you hire an amateur."
				    Paul Neal "Red" Adair 

A. R. Ivanov
E-mail:  anton.ivanov@kot-begemot.co.uk


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

