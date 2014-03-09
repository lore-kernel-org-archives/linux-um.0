Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WMXyo-0006hc-Lm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Mar 2014 07:17:02 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WMXyn-00079m-5b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Mar 2014 07:17:02 +0000
Message-ID: <531C1559.2080404@kot-begemot.co.uk>
Date: Sun, 09 Mar 2014 07:16:41 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1394217468-734972-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<1394217468-734972-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<531BA8D0.2050307@nod.at>
In-Reply-To: <531BA8D0.2050307@nod.at>
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
Subject: Re: [uml-devel] [PATCH 3/3] BUG: Inapprorpiate choice of IPC
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Yes, that is why I resent it.

My mistake when moving the commits from the main tree to a branch which
was just for submission.

The file.c frag is from patch-2 (the memory corruption one).

Please use the resent version, it has them in the right places.
Alternatively, I can resend them again off-list.

A.

On 08/03/14 23:33, Richard Weinberger wrote:
>
> Am 07.03.2014 19:37, schrieb anton.ivanov@kot-begemot.co.uk:
>> From: Anton Ivanov <antivano@cisco.com>
>>
>> PIPE is the wrong IPC for this type of inter-thread communication.
>>
>> For more details see:
>>
>> http://stackoverflow.com/questions/4624071/pipe-buffer-size-is-4k-or-64k
>>
>> The observations on that thread have been confirmed by us for UML's
>> UBD driver. If you load UML with network IO and do disk IO at the same
>> time the UBD IO helper thread fails to process requests fast enough.
>>
>> In most cases this will lead to a slowdown in disk IO as well as
>> inability to execute new processes until the network load goes away.
>> In some cases however it will not recover. Example - with our new high
>> performance 1G+ network drivers a wget of 1G file from the network
>> is a nearly guaranteed crash if it writes out to UBD.
>>
>> The crashes and the slowdowns are not observed with this patch -
>> it switches the IPC to socket which does not have the pipe granularity
>> and queue size problems.
>>
>> This signifies a problem with overall UBD error handling which this
>> patch fails to fix. The workaround should be good enough for most
>> cases.
>>
>> Signed-off-by: Anton Ivanov <antivano@cisco.com>
>> ---
>>  arch/um/drivers/ubd_kern.c |    2 +-
>>  arch/um/drivers/ubd_user.c |    2 +-
>>  arch/um/os-Linux/file.c    |    2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>> index 944453a..c9a5717 100644
>> --- a/arch/um/drivers/ubd_kern.c
>> +++ b/arch/um/drivers/ubd_kern.c
>> @@ -1291,7 +1291,7 @@ static void do_ubd_request(struct request_queue *q)
>>  			n = os_write_file(thread_fd, &io_req,
>>  					  sizeof(struct io_thread_req *));
>>  			if(n != sizeof(struct io_thread_req *)){
>> -				if(n != -EAGAIN)
>> +				if(!((n == -EAGAIN) || (n == -ENOBUFS)))
>>  					printk("write to io thread failed, "
>>  					       "errno = %d\n", -n);
>>  				else if(list_empty(&dev->restart))
>> diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
>> index 007b94d..f1f84a4 100644
>> --- a/arch/um/drivers/ubd_user.c
>> +++ b/arch/um/drivers/ubd_user.c
>> @@ -32,7 +32,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
>>  {
>>  	int pid, fds[2], err;
>>  
>> -	err = os_pipe(fds, 1, 1);
>> +	err = socketpair(AF_UNIX, SOCK_STREAM, 0, (int *) &fds);
>>  	if(err < 0){
>>  		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
>>  		goto out;
>> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
>> index c879b12..a4f0e65 100644
>> --- a/arch/um/os-Linux/file.c
>> +++ b/arch/um/os-Linux/file.c
>> @@ -240,7 +240,7 @@ void os_close_file(int fd)
>>  int os_fsync_file(int fd)
>>  {
>>  	if (fsync(fd) < 0) 
>> -	    return -errno
>> +	    return -errno;
> Huh?
> I think this does not belong to the patch.
>
> The other drivers look good. Thanks a lot for pushing this work upstream!
> We are already at -rc5. I'll send the patches to Linus within the next merge window
> and mark them for stable.
>
> Thanks,
> //richard
>


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

