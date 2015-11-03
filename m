Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtVkx-0000Co-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Nov 2015 07:11:47 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZtVkw-0007xj-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Nov 2015 07:11:47 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtVkp-0001cK-Ql
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Nov 2015 07:11:39 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtVkp-0005nu-ID
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Nov 2015 07:11:39 +0000
Message-ID: <56385E2A.4040401@kot-begemot.co.uk>
Date: Tue, 03 Nov 2015 07:11:38 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>	<5637DA94.5000302@nod.at>
	<5637E000.7020202@kot-begemot.co.uk>
In-Reply-To: <5637E000.7020202@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: user-mode-linux-devel@lists.sourceforge.net

On 02/11/15 22:13, Anton Ivanov wrote:
> On 02/11/15 21:50, Richard Weinberger wrote:
>> Am 02.11.2015 um 17:16 schrieb Anton Ivanov:
>>> -void idle_sleep(unsigned long long nsecs)
>>> +/**
>>> + * os_idle_sleep() - sleep for a given time of nsecs
>>> + * @nsecs: nanoseconds to sleep
>>> + */
>>> +void os_idle_sleep(unsigned long long nsecs)
>>>   {
>>>   	struct timespec ts;
>>>   
>>> -	/*
>>> -	 * nsecs can come in as zero, in which case, this starts a
>>> -	 * busy loop.  To prevent this, reset nsecs to the tick
>>> -	 * interval if it is zero.
>>> -	 */
>>> -	if (nsecs == 0)
>>> -		nsecs = UM_NSEC_PER_SEC / UM_HZ;
>>> +	if (nsecs <= 0) {
>>> +		return;
>>> +	}
>>>   
>>> -	nsecs = sleep_time(nsecs);
>>> -	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
>>> -				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
>>> +	ts = ((struct timespec) {
>>> +			.tv_sec  = nsecs / UM_NSEC_PER_SEC,
>>> +			.tv_nsec = nsecs % UM_NSEC_PER_SEC
>>> +	});
>>>   
>>> -	if (nanosleep(&ts, &ts) == 0)
>>> +	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL)) {
>>>   		deliver_alarm();
>>> -	after_sleep_interval(&ts);
>>> +	}
>> Hmm, now this function sleeps at most nsecs. If it is interrupted
>> the alarm is delivered.
>> Why only upon interruption and not also if clock_nanosleep()
>> completes?
> It is invoked differently.
>
> We changed process.c too.
>
> The old behaviour used to be to disable the timer, read timer remaining
> and program a nanosleep with that. This resulted in the timer actually
> firing in idle despite UML using the virtual clock for timers.
>
> With timer moving to MONOTONIC we could do the same, but we do not need
> to. Instead of disabling the timer we can leave it running and program a
> nanosleep which is long enough in most cases for the timer to fire. This
> is what the matching change in process.c does. Together, this results in
> saving at least 2 syscalls per each idle invocation.

Re-reading this, I did not answer the question fully, apologies.

clock_nanosleep here is usually programmed with a fixed value in 
process.c which is of no relation to the time when the next timer 
interrupt should be delivered. So there is no need to re-deliver an 
interrupt at the end of a nanosleep as the end of the nanosleep is of no 
significance as far as the timer subsystem is concerned.

IMHO, the IRQ only needs to be relayed when the nanosleep is interrupted.

That differs to the old behaviour which programmed the nanosleep with 
the remainder of the time till the next interrupt thus making it 
necessary to relay once the nanosleep expires and restart the nanosleep 
if it was interrupted by IO.

A.

>
> A.
>
>> Thanks,
>> //richard
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

