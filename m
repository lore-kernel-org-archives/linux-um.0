Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx2Tl-0003ny-SM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:22:29 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cx2Tl-0005Mj-Ai for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:22:29 -0800
Message-ID: <42036C2C.5040503@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <42021E35.8050601@fujitsu-siemens.com>
	<4202C18F.5010605@yahoo.com.au>
In-Reply-To: <4202C18F.5010605@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Race condition in ptrace
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 04 Feb 2005 13:35:56 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Roland Mc Grath <roland@redhat.com>, Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Bodo Stroesser wrote:
> 
>> Working with the new UML skas0 mode on my Xeon HT host, sporadically I 
>> saw
>> some processes on UML segfaulting.
>>
>> In all cases, I could track this down to be caused by a gs segment 
>> register,
>> that had the wrong contents.
>>
>> This again is caused by a problem in the host linux: A ptraced child 
>> going to
>> stop and having woken up its parent, will save some of its registers 
>> (on i386
>> they are fs, gs and the fp-registers) very late in switch_to. The 
>> parent is
>> granted access to child's registers as soon, as the child is removed from
>> the runqueue. Thus, in rare cases, the parent might access child's 
>> register
>> savearea before the registers really are saved.
>>
>> This problem might also be the reason for problems with floatpoint on 
>> UML,
>> that were reported some time ago.
>>
>> I've written a test program, that reproduces the problem on my 2.6.9 
>> vanilla
>> host quite quick. Using SuSE kernel 2.6.5-7.97-smp, I can't reproduce the
>> problem, although the relevant parts seem to be unchanged. Maybe not 
>> related
>> changes modify the timing?
>>
>> I also created a patch, that fixes the problem on my 2.6.9 host. This 
>> probably
>> isn't a sane patch, but is enough to demonstrate, where I think, the 
>> bug is.
>> Both files are attached.
>>
>>        Bodo
>>
>>
>> ------------------------------------------------------------------------
>>
>> --- a/include/linux/sched.h    2005-02-02 22:15:51.000000000 +0100
>> +++ b/include/linux/sched.h    2005-02-02 22:22:54.000000000 +0100
>> @@ -584,6 +584,7 @@ struct task_struct {
>>        struct mempolicy *mempolicy;
>>        short il_next;        /* could be shared with used_math */
>>  #endif
>> +    volatile long saving;
>>  };
>>  
>>  static inline pid_t process_group(struct task_struct *tsk)
>> --- a/kernel/sched.c    2005-02-02 21:32:51.000000000 +0100
>> +++ b/kernel/sched.c    2005-02-02 22:12:14.000000000 +0100
>> @@ -2689,8 +2689,10 @@ need_resched:
>>          if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
>>                  unlikely(signal_pending(prev))))
>>              prev->state = TASK_RUNNING;
>> -        else
>> +        else {
>> +            prev->saving = 1;
>>              deactivate_task(prev, rq);
>> +        }
>>      }
>>  
>>      cpu = smp_processor_id();
>> --- a/kernel/ptrace.c    2005-02-02 22:12:33.000000000 +0100
>> +++ b/kernel/ptrace.c    2005-02-02 22:20:46.000000000 +0100
>> @@ -96,6 +96,7 @@ int ptrace_check_attach(struct task_stru
>>  
>>      if (!ret && !kill) {
>>          wait_task_inactive(child);
>> +        while ( child->saving ) ;
>>      }
>>  
>>      /* All systems go.. */
>> --- a/arch/i386/kernel/process.c    2005-02-02 22:18:29.000000000 +0100
>> +++ b/arch/i386/kernel/process.c    2005-02-02 22:19:22.000000000 +0100
>> @@ -577,6 +577,9 @@ struct task_struct fastcall * __switch_t
>>      asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
>>      asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
>>  
>> +    wmb();
>> +    prev_p->saving=0;
>> +
>>      /*
>>       * Restore %fs and %gs if needed.
>>       */
>>
> 
> I don't see how this could help because AFAIKS, child->saving is only
> set and cleared while the runqueue is locked. And the same runqueue lock
> is taken by wait_task_inactive.
> 

Sorry, that not right. There are some routines called by sched(), that release
and reacquire the runqueue lock.

Bodo


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
