Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antivano@cisco.com>) id 1Wbzk4-0002L6-P0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Apr 2014 21:57:40 +0000
Received: from rcdn-iport-3.cisco.com ([173.37.86.74])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wbzk1-0006VZ-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Apr 2014 21:57:40 +0000
From: "Anton Ivanov (antivano)" <antivano@cisco.com>
Date: Sun, 20 Apr 2014 21:57:30 +0000
Message-ID: <53544298.20904@cisco.com>
References: <1394217468-734972-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<1394217468-734972-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<53543BF7.80507@nod.at>
In-Reply-To: <53543BF7.80507@nod.at>
Content-Language: en-US
Content-ID: <E10FAEF5F218F34688CBE0E2C29F1BE3@emea.cisco.com>
MIME-Version: 1.0
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
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

OK. Cool.

It was vs 3.3.8 (openwrt) so it may not apply cleanly vs 3.15. I will
fix it and resubmit it.

A.

On 20/04/14 22:28, Richard Weinberger wrote:
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
>>  	return 0;
>>  }
> FYI, I did not send this patch to Linus because it does not apply.
> Please fix this. :-)
>
> Thanks,
> //richard

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

