Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hVA9Z-0000EV-PX
 for linux-um@lists.infradead.org; Mon, 27 May 2019 07:34:43 +0000
Subject: Re: [PATCH v2 5/5] arch: um: support virtual time
References: <20190506123939.21091-1-johannes@sipsolutions.net>
 <20190506123939.21091-6-johannes@sipsolutions.net>
 <CAFLxGvza1da-q=XakFimKc-aZd5M9bSxtNZdvLmTz5_Ck1HJ3Q@mail.gmail.com>
 <6a6dd0548031aedc34044d89953e4c8c9d7e45f5.camel@sipsolutions.net>
 <5a0d83d0-1f68-c1ae-468b-b88752472a84@kot-begemot.co.uk>
 <0b04985bdb25de7373ea614c80c7773146d2498b.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <abe8e1f4-3b17-386e-befb-0801c6840fcc@kot-begemot.co.uk>
Date: Mon, 27 May 2019 08:34:33 +0100
MIME-Version: 1.0
In-Reply-To: <0b04985bdb25de7373ea614c80c7773146d2498b.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard.weinberger@gmail.com>
Cc: j@w1.fi, linux-um@lists.infradead.org



On 27/05/2019 07:50, Johannes Berg wrote:
> On Mon, 2019-05-27 at 05:47 +0100, Anton Ivanov wrote:
>> ITIMER_VIRTUAL This timer counts down against the  user-mode  CPU  time
>> consumed  by the process.  (The measurement includes CPU
>>    time consumed by all threads in the process.)   At  each expiration, a
>> SIGVTALRM signal is generated.
>>
>> This is what we used to use before we migrated to POSIX timers.
>>
>> So as far as the name there is a possible name clash/term overload.
> 
> Good point.
> 
>>>
>>>> To me "virtual time" reads like a clock that runs with different speed or is in
>>>> some other way untangled from the host.
>>>> What you have implement is time traveling. ;-)
>>>
>>> True :-)
>>
>> +1, Let's just call it time travel mode.
> 
> :-)
> 
> Checking those references from my colleague now, I see the terms
>   * (adaptive) time dilation - at least for the other case I haven't
>     included in this patch yet where the clock can run slower than real
>     time
>   * virtual time - which is closest to what I called "infinite CPU power"
>     before
>   * relativistic time - which is close but not really what I implemented
>     here either
> 
> But sure, let's just call it "time-travel".
> 
> I think I'll add a few options:
> 
>   * time-travel=faster - what's implemented by this patch
>   * time-travel=infcpu - infinite CPU power available
>   * time-travel-start=<int value>
>                        - start of real time, to not necessarily use wall
>                          clock
> 
> Seems reasonable?

Yes. It also clearly distinguishes it from virtual time which is 
something which is used in a few places as a term.

Best Regards,


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
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

