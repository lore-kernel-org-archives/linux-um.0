Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1YpWqR-00010j-Dz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 May 2015 07:00:43 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YpWqP-000308-BH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 May 2015 07:00:43 +0000
References: <1430560088.603436.25.camel@m3y3r.de>
	<5544B03D.5070509@kot-begemot.co.uk>
	<1430667970.603436.29.camel@m3y3r.de>
	<55479CD6.2000000@kot-begemot.co.uk>
Mime-Version: 1.0 (1.0)
In-Reply-To: <55479CD6.2000000@kot-begemot.co.uk>
Message-Id: <7FA96EC2-E983-4904-A64C-9AC006AF8A6F@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Tue, 5 May 2015 09:00:20 +0200
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
Subject: Re: [uml-devel] [PATCH v5] um: Add a high resolution timer subsystem
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>



> Am 04.05.2015 um 18:22 schrieb Anton Ivanov <anton.ivanov@kot-begemot.co.uk>:
> 
> Hi Thomas,

Hi Anton,

> 
>     I read it and like it except idle sleep. See my comments inline. I 
> killed that nanosleep quite on purpose :)

Okay. I think I understand now.

> 
>     With what you did to the tramp the issue of userspace stalling 
> should go away by the way (in theory). I think that it will still show a 
> very HZ behavior, but IMHO that cannot be helped at this stage.

Do you mean the user space processes with above statement? What else could be done with them if not trigger at HZ?

> 
> A.
> 
> 
>> On 03/05/15 16:46, Thomas Meyer wrote:
>> Am Samstag, den 02.05.2015, 12:08 +0100 schrieb Anton Ivanov:

>>   * This is a per-cpu array.  A processor only modifies its entry and it only
>> @@ -204,8 +205,16 @@ void arch_cpu_idle(void)
>>      unsigned long long nsecs;
>> 
>>      cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
>> -    nsecs = disable_timer();
>> -    idle_sleep(nsecs);
>> +
>> +    //WHAT?
> 
> The way idle sleep was originally implemented is by setting a nanosleep 
> for nsecs until the next expected timer firing. After that the sleep 
> routine used to generated a timer interrupt.
> 
> It was killing two ducks with one shot - the original timer is based on 
> VTALRM and virtual clock. So if you are idle enough to go into sleep you 
> cannot rely on the signal from itimer (as this is dependent on your CPU 
> usage) to wake you up on time. In fact, you are never going to wake up.
> 
> Setting a nano-sleep dealt with both problems - idle sleeping and waking 
> up on time as expressed in absolute wall clock.
> 
> If your wall clock is no longer running off VIRTUAL and is now off 
> MONOTONIC you do not need to do this. You just go to sleep without 
> disabling the next timer interrupt, the next timer interrupt happens on 
> schedule (as it is now off the right clock), you wake up from sleep. Two 
> syscalls less, same effect.

Okay, I'll change that. In your original patch you wait maximum for one HZ interval, why not wait forever os_idle_sleep()? 
> 
> 
> 
>> +    /* there is no benefit whatsoever in disabling a pending
>> +     * hrtimer and setting a nanowait for the same value instead
>> +     * so we do timer disable + wait only for the tracing one here
>> +     */
>> +
>> +    nsecs = os_timer_disable();
>> +    os_idle_sleep(nsecs);
>> +    os_timer_set_interval(NULL);
> 
> This is wrong as nsec is time to next timer firing. You just used two 
> syscalls to achieve the same effect as leaving the timer lapse while 
> going to sleep. See above.
> 
>>      local_irq_enable();
>>  }
>> 
>> diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
>> index 289771d..c1cdc2e 100644
>> --- a/arch/um/kernel/skas/clone.c
>> +++ b/arch/um/kernel/skas/clone.c
>> @@ -35,10 +35,11 @@ stub_clone_handler(void)
>>      if (err)
>>          goto out;
>> 
>> -    err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
>> -                (long) &data->timer, 0);
>> -    if (err)
>> -        goto out;
>> +// WHY? FIXME: Switch to timer_create, timer_settime needed?!
>> +//    err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
>> +//                (long) &data->timer, 0);
>> +//    if (err)
>> +//        goto out;
> 
> Beats me - if you do not do it, userspace stalls. Though I see you do it 
> now in the tramp. I need to test that :)

I'm not sure about that yet.
I really need to figure out when above code is called. Sadly I seem to hit some assertion in gdb and this kills my gdb session :-(
I'll look into the gdb code to understand what assert it is hitting. Did you see similar problems while debugging the uml kernel executable?

I think start_userspace is one way of creating a new userspace process, maybe there are other ways to reach above code from a clone call that will start a new user space process?! That would be the only thing that would make sense... If so an posix interval timer need to be created in above code.

>> +/**
>> + * userspace() - user space control loop
>> + * @regs: ?
>> + *
>> + * The main loop that traces and controls each spwaned userspace
>> + * process, i.e.
>> + */
>>  void userspace(struct uml_pt_regs *regs)
>>  {
>> -    struct itimerval timer;
>> -    unsigned long long nsecs, now;
>> +    unsigned long long nsecs;
>>      int err, status, op, pid = userspace_pid[0];
>>      /* To prevent races if using_sysemu changes under us.*/
>>      int local_using_sysemu;
>> @@ -325,13 +371,11 @@ void userspace(struct uml_pt_regs *regs)
>>      /* Handle any immediate reschedules or signals */
>>      interrupt_end();
>> 
>> -    if (getitimer(ITIMER_VIRTUAL, &timer))
>> -        printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
>> -    nsecs = timer.it_value.tv_sec * UM_NSEC_PER_SEC +
>> -        timer.it_value.tv_usec * UM_NSEC_PER_USEC;
>> -    nsecs += os_nsecs();
>> -
>>      while (1) {
>> +
>> +        nsecs = os_timer_remain(NULL);
>> +        nsecs += os_nsecs();
>> +
>>          /*
>>           * This can legitimately fail if the process loads a
>>           * bogus value into a segment register.  It will
>> @@ -388,31 +432,27 @@ void userspace(struct uml_pt_regs *regs)
>>              switch (sig) {
>>              case SIGSEGV:
>>                  if (PTRACE_FULL_FAULTINFO) {
>> -                    get_skas_faultinfo(pid,
>> -                               &regs->faultinfo);
>> -                    (*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
>> -                                 regs);
>> +                    get_skas_faultinfo(pid,&regs->faultinfo);
>> +                    (*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si, regs);
>> +                } else {
>> +                    handle_segv(pid, regs);
>>                  }
>> -                else handle_segv(pid, regs);
>>                  break;
>>              case SIGTRAP + 0x80:
>> -                    handle_trap(pid, regs, local_using_sysemu);
>> +                handle_trap(pid, regs, local_using_sysemu);
>>                  break;
>>              case SIGTRAP:
>>                  relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
>>                  break;
>> -            case SIGVTALRM:
>> -                now = os_nsecs();
>> -                if (now < nsecs)
>> +            case SIGUSR2:
> 
> We need to look into this one - it was here because VTALRM can produce a 
> significant difference between the time the kernel one fires and the 
> userspace fires. If the kernel one uses MONOTONIC to an exact time and 
> the userspace uses MONOTONIC to pace it to firings from "interval" sets 
> you end up with HZ scheduling and HZ timer precision instead of the 
> scheduler and userspace timers as we know it in today's Linux.

Okay, yes I understand now.

But currently the user space posix interval timers are not created synchronised compared to the kernel interval timer. So there is very likely a gap between the firing of all timers.
Creating all timer to fire in HZ rate at exactly the same time is the correct thing to do in my opinion. What do you think?


Do we need to take care of CONFIG_NO_HZ_IDLE AND CONFIG_NO_HZ_FULL?!

With kind regards
Thomas


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

