Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hN1V0-0003IZ-AE
 for linux-um@lists.infradead.org; Sat, 04 May 2019 20:43:12 +0000
Subject: Re: [PATCH 3/3] arch: um: support virtual time
References: <20190503213249.30008-1-johannes@sipsolutions.net>
 <20190503213249.30008-3-johannes@sipsolutions.net>
 <95430ca975e73addc7f65e331488bc280974fd72.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <9f844312-dca3-d20e-485b-13c1f249edb0@cambridgegreys.com>
Date: Sat, 4 May 2019 21:42:23 +0100
MIME-Version: 1.0
In-Reply-To: <95430ca975e73addc7f65e331488bc280974fd72.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>



On 04/05/2019 20:05, Johannes Berg wrote:
> On Fri, 2019-05-03 at 21:32 +0000, Johannes Berg wrote:
>>
>> @@ -65,12 +75,17 @@ int os_timer_set_interval(void)
>>
>>          if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
>>                  return -errno;
>> +#else
>> +       timer_enabled = true;
>> +       timer_expiry = virtual_time + UM_NSEC_PER_SEC / UM_HZ;
>> +#endif
> 
> This is broken in two ways - first of all, I missed the interval
> completely, and secondly if you end up with a process that does
> something like
> 
>   x = gettime();
>   while (x == gettime()) { /* nothing */ }
> 
> then it gets stuck forever ...
> 
> I have a new version almost ready.
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

I had a quick look at them.

1 and 2 are clear and I will most likely ack them once you have a final 
version.

I can understand your use case for patch 3. What I am not clear is where 
should that config option live. It should be somewhere under 
debug/kernel hacking with a sufficient number of big fat warnings so 
people do not enable it accidentally by mistake.

Ideas?

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

