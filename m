Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KdRUp-0003ux-Ve for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 08:20:45 -0700
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KdRPu-00054G-E1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 08:15:39 -0700
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id m8AFFQBY016716
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 15:15:27 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8AFFQ7l4579562
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 16:15:26 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8AFFPsn027521 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 16:15:26 +0100
Message-ID: <48C7E3A9.3060602@linux.vnet.ibm.com>
Date: Wed, 10 Sep 2008 17:11:37 +0200
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <48C51439.7000706@linux.vnet.ibm.com>
	<20080909124302.GA139@tv-sign.ru>
In-Reply-To: <20080909124302.GA139@tv-sign.ru>
Subject: Re: [uml-devel] [PATCH 1/1] system call notification with self_ptrace
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, gregkh@suse.de, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>

Hello,

Oleg Nesterov wrote:
> On 09/08, Pierre Morel wrote:
>   
>> --- linux-2.6.26.orig/arch/s390/kernel/signal.c
>> +++ linux-2.6.26/arch/s390/kernel/signal.c
>> @@ -409,6 +409,11 @@ handle_signal(unsigned long sig, struct 
>> 		spin_unlock_irq(&current->sighand->siglock);
>> 	}
>>
>> +	if (current->instrumentation) {
>> +		clear_thread_flag(TIF_SYSCALL_TRACE);
>> +		current->instrumentation &= ~PTS_SELF;
>> +	}
>> +
>> 	return ret;
>> }
>>     
>
> I still think this patch shouldn't change handle_signal().
>
> Once again. The signal handler for SIGSYS can first do
> sys_ptrace(PTRACE_SELF_OFF) (which is filtered out), and then use any
> other syscall, so this change is not needed, afaics.
>   
Yes it can but what if the application forget to do it?
It is a security so that the application do not bounce for ever.
> The overhead of the additional PTRACE_SELF_OFF syscall is very small,
> especially compared to signal delivery. I don't think this functionality
> will be widely used, but this change adds the unconditional overhead
> to handle_signal().
>
> Btw, the check above looks wrong, shouldn't it be
>
> 	if (current->instrumentation & PTS_SELF)
>
> ?
>   
Yes you are right, in fact I do not need two flags, I will remove
the PTS_INSTRUMENTED flag.
> And. According to the prior discussion, this requires to hook every
> signal handler in user space, otherwise we can miss syscall. But every
> hook should start with PTRACE_SELF_ON, so I can't see any gain.
>
>   
>> +#define PTS_INSTRUMENTED	0x00000001
>> +#define PTS_SELF	0x00000002
>>     
>
> I don't really understand why do we need 2 flags, see also below,
>   
Yes, I remove PTS_INSTRUMENTED, a bad idea.
>   
>> --- linux-2.6.26.orig/kernel/ptrace.c
>> +++ linux-2.6.26/kernel/ptrace.c
>> @@ -543,6 +543,38 @@ asmlinkage long sys_ptrace(long request,
>> 	 * This lock_kernel fixes a subtle race with suid exec
>> 	 */
>> 	lock_kernel();
>> +	if (request == PTRACE_SELF_ON) {
>> +		task_lock(current);
>> +		if (current->ptrace) {
>> +			task_unlock(current);
>> +			ret = -EPERM;
>> +			goto out;
>> +		}
>> +		set_thread_flag(TIF_SYSCALL_TRACE);
>> +		current->instrumentation |= PTS_INSTRUMENTED|PTS_SELF;
>> +		task_unlock(current);
>> +		ret = 0;
>> +		goto out;
>>     
>
> The code looks strange. How about
>
> 	if (request == PTRACE_SELF_ON) {
> 		ret = -EPERM;
> 		task_lock(current);
> 		if (!current->ptrace) {
> 			set_thread_flag(TIF_SYSCALL_TRACE);
> 			current->instrumentation |= PTS_INSTRUMENTED|PTS_SELF;
> 			ret = 0;
> 		}
> 		task_unlock(current);
> 		goto out;
> 	}
>
> ?
>
> I don't understand how task_lock() can help. This code runs under
> lock_kernel(), and without this lock the code is racy anyway.
>   

I use task_lock to protect the current->ptrace bit-field which can be 
accessed by another thread, like the one you pointed out previously.
I agree it is not necessary with lock_kernel().
I will put the code before the lock_kernel() to be more efficient.
>   
>> +	}
>> +	if (request == PTRACE_SELF_OFF) {
>> +		task_lock(current);
>> +		if (current->ptrace) {
>> +			task_unlock(current);
>> +			ret = -EPERM;
>> +			goto out;
>> +		}
>> +		clear_thread_flag(TIF_SYSCALL_TRACE);
>> +		current->instrumentation &= ~PTS_SELF;
>>     
>
> So. PTRACE_SELF_OFF doesn't clear PTS_INSTRUMENTED? How can the task
> reset ->instrumentation ?
>   
You are right again, I will remove the PTS_INSTRUMENTED flag.
>   
>> +	if (current->instrumentation) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>>     
>
> So, PTRACE_SELF_XXX disables the "normal" ptrace. Not sure this is good.
>   
I think that having two tracing system one over the other may be
quite difficult to handle.

Pierre
> Oleg.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   


-- 
=============
Pierre Morel
RTOS and Embedded Linux


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
