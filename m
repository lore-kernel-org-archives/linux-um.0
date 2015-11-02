Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtNM7-0002A9-Qv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 22:13:35 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZtNM6-0002On-GZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 22:13:35 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtNLz-0001Qv-9c
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 22:13:27 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
	by smaug.kot-begemot.co.uk with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtNLz-00031U-1t
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 22:13:27 +0000
Message-ID: <5637E000.7020202@kot-begemot.co.uk>
Date: Mon, 02 Nov 2015 22:13:20 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<5637DA94.5000302@nod.at>
In-Reply-To: <5637DA94.5000302@nod.at>
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

On 02/11/15 21:50, Richard Weinberger wrote:
> Am 02.11.2015 um 17:16 schrieb Anton Ivanov:
>> -void idle_sleep(unsigned long long nsecs)
>> +/**
>> + * os_idle_sleep() - sleep for a given time of nsecs
>> + * @nsecs: nanoseconds to sleep
>> + */
>> +void os_idle_sleep(unsigned long long nsecs)
>>  {
>>  	struct timespec ts;
>>  
>> -	/*
>> -	 * nsecs can come in as zero, in which case, this starts a
>> -	 * busy loop.  To prevent this, reset nsecs to the tick
>> -	 * interval if it is zero.
>> -	 */
>> -	if (nsecs == 0)
>> -		nsecs = UM_NSEC_PER_SEC / UM_HZ;
>> +	if (nsecs <= 0) {
>> +		return;
>> +	}
>>  
>> -	nsecs = sleep_time(nsecs);
>> -	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
>> -				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
>> +	ts = ((struct timespec) {
>> +			.tv_sec  = nsecs / UM_NSEC_PER_SEC,
>> +			.tv_nsec = nsecs % UM_NSEC_PER_SEC
>> +	});
>>  
>> -	if (nanosleep(&ts, &ts) == 0)
>> +	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL)) {
>>  		deliver_alarm();
>> -	after_sleep_interval(&ts);
>> +	}
> Hmm, now this function sleeps at most nsecs. If it is interrupted
> the alarm is delivered.
> Why only upon interruption and not also if clock_nanosleep()
> completes?

It is invoked differently.

We changed process.c too.

The old behaviour used to be to disable the timer, read timer remaining
and program a nanosleep with that. This resulted in the timer actually
firing in idle despite UML using the virtual clock for timers.

With timer moving to MONOTONIC we could do the same, but we do not need
to. Instead of disabling the timer we can leave it running and program a
nanosleep which is long enough in most cases for the timer to fire. This
is what the matching change in process.c does. Together, this results in
saving at least 2 syscalls per each idle invocation.

A.

>
> Thanks,
> //richard
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

