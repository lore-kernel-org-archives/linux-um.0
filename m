Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZtMzf-00076q-2j
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 21:50:23 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZtMzc-0001XC-W5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 21:50:22 +0000
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5637DA94.5000302@nod.at>
Date: Mon, 2 Nov 2015 22:50:12 +0100
MIME-Version: 1.0
In-Reply-To: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
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
To: Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Meyer <thomas@m3y3r.de>

Am 02.11.2015 um 17:16 schrieb Anton Ivanov:
> -void idle_sleep(unsigned long long nsecs)
> +/**
> + * os_idle_sleep() - sleep for a given time of nsecs
> + * @nsecs: nanoseconds to sleep
> + */
> +void os_idle_sleep(unsigned long long nsecs)
>  {
>  	struct timespec ts;
>  
> -	/*
> -	 * nsecs can come in as zero, in which case, this starts a
> -	 * busy loop.  To prevent this, reset nsecs to the tick
> -	 * interval if it is zero.
> -	 */
> -	if (nsecs == 0)
> -		nsecs = UM_NSEC_PER_SEC / UM_HZ;
> +	if (nsecs <= 0) {
> +		return;
> +	}
>  
> -	nsecs = sleep_time(nsecs);
> -	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
> -				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
> +	ts = ((struct timespec) {
> +			.tv_sec  = nsecs / UM_NSEC_PER_SEC,
> +			.tv_nsec = nsecs % UM_NSEC_PER_SEC
> +	});
>  
> -	if (nanosleep(&ts, &ts) == 0)
> +	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL)) {
>  		deliver_alarm();
> -	after_sleep_interval(&ts);
> +	}

Hmm, now this function sleeps at most nsecs. If it is interrupted
the alarm is delivered.
Why only upon interruption and not also if clock_nanosleep()
completes?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

