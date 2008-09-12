Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke7y2-0007Dp-2v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:41:42 -0700
Received: from mtagate3.de.ibm.com ([195.212.29.152])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ke7y0-0005vh-DS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:41:42 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8CCNPCv042006
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 12:23:25 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8CCNPP14079698
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:23:25 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8CCNLg8021254 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:23:21 +0200
Message-ID: <48CA5E4F.2020600@linux.vnet.ibm.com>
Date: Fri, 12 Sep 2008 14:19:27 +0200
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <48C51439.7000706@linux.vnet.ibm.com>
	<20080909124302.GA139@tv-sign.ru>
	<48C7E3A9.3060602@linux.vnet.ibm.com>
	<20080910162008.GA401@tv-sign.ru>
In-Reply-To: <20080910162008.GA401@tv-sign.ru>
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

Hello Oleg,

You are right, the functionality can be implemented with the system call.
But it means we have the overhead of a system call just to clear two bits,
the TIF_SYSCALL_TRACE and the PTS_SELF.

On the other hand we have an overhead of one single "if" inside
the handle_signal() function.

We can do the same with fork and ptrace, yes, but with a very big 
overhead on each system call and this is why this patch is so usefull: 
because with this patch you sit inside the thread when analysing it and 
have a direct access to all data without the need of IPC, ptrace or any 
task switch.

I will provide a test program and plan to release a tracing tool based 
on it.
I think I can reduce the task struct modification by using just a bit 
like you suggest if nobody seen any problem with this.

best regards,

Pierre

Oleg Nesterov wrote:
> On 09/10, Pierre Morel wrote:
>   
>> Oleg Nesterov wrote:
>>     
>>> I still think this patch shouldn't change handle_signal().
>>>
>>> Once again. The signal handler for SIGSYS can first do
>>> sys_ptrace(PTRACE_SELF_OFF) (which is filtered out), and then use any
>>> other syscall, so this change is not needed, afaics.
>>>
>>>       
>> Yes it can but what if the application forget to do it?
>> It is a security so that the application do not bounce for ever.
>>     
>
> The (buggy) task can be killed, this has nothing to do with security.
>
> From the security pov, this case doesn't differ from, say,
>
> 	void sigh(int sig)
> 	{
> 		kill(getpid(), sig);
> 	}
>
> 	void main(void)
> 	{
> 		signal(SIGSYS, sigh);
> 		kill(getpid(), SIGSYS);
> 	}
>
> Or I missed something?
>
>   
>>> So, PTRACE_SELF_XXX disables the "normal" ptrace. Not sure this is good.
>>>
>>>       
>> I think that having two tracing system one over the other may be
>> quite difficult to handle.
>>     
>
> Yes I see.
>
> But... well, I think we need Roland's opinion. I must admit, I am a bit
> sceptical about this patch ;) I mean, I don't really understand why it
> is useful. We can do the same with fork() + ptrace(). Yes, in that
> case we need an "extra" context switch for any traced syscall. But,
> do you have any "real life" example to demonstrate that the user-space
> solution sucks? We can even use CLONE_MM to speedup the context switch.
>
> Pierre, don't get me wrong. I never used debuggers for myself, I will
> be happy to know I am wrong. I just don't understand.
>
>
> As for ->instrumentation. If you are going to remove PTS_INSTRUMENTED,
> we need only one bit. We could use PF_PTS_SELF, but ->flags is already
> "contended". Perhaps you can do something like
>
> 	--- include/linux/sched.h
> 	+++ include/linux/sched.h
> 	@@ -1088,6 +1088,7 @@ struct task_struct {
> 		/* ??? */
> 		unsigned int personality;
> 		unsigned did_exec:1;
> 	+	unsigned pts_self:1;
> 		pid_t pid;
> 		pid_t tgid;
> 	 
>
> Both did_exec and pts_self can only be changed by current, so it is
> safe to share the same word. This way we don't enlarge task_struct.
>
> Oleg.
>
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
