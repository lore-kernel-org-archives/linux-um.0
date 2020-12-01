Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk3d4-0006JR-Gu
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 11:15:31 +0000
Subject: Re: [PATCH v6 1/5] um: simplify os_idle_sleep() and sleep longer
References: <20201130121550.173513-1-johannes@sipsolutions.net>
 <20201130131520.3a0d2a5443a2.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
 <a4c36b0f08839904a37dd5419a0e85cc96ae90a9.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <797238e2-114a-c658-164f-a9e0568902ec@kot-begemot.co.uk>
Date: Tue, 1 Dec 2020 11:15:25 +0000
MIME-Version: 1.0
In-Reply-To: <a4c36b0f08839904a37dd5419a0e85cc96ae90a9.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org

On 01/12/2020 10:57, Johannes Berg wrote:
> On Mon, 2020-11-30 at 13:15 +0100, Johannes Berg wrote:
>> -void os_idle_sleep(unsigned long long nsecs)
>> +void os_idle_sleep(void)
>>   {
>> -	struct timespec ts = {
>> -		.tv_sec  = nsecs / UM_NSEC_PER_SEC,
>> -		.tv_nsec = nsecs % UM_NSEC_PER_SEC
>> -	};
>> -
>> -	/*
>> -	 * Relay the signal if clock_nanosleep is interrupted.
>> -	 */
>> -	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
>> -		deliver_alarm();
>> +	select(0, NULL, NULL, NULL, NULL);
>>
> I found out about the pause() syscall the other day. Maybe we should use
> that here? It's basically equivalent, though with a shorter kernel code
> path?

I had a gut feeling that there has to be a better way :)

Yes. Definitely.

>
> johannes
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

