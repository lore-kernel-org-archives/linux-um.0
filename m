Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZDjL-00Cx7B-Oo
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 14:21:29 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1lZDjH-0005n4-N1
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 14:21:23 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1lZDjF-0002Vp-C8
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 15:21:23 +0100
Subject: Re: Race between SIGIO and epoll from SMP host
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
 <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
 <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4992839c-447f-f28e-fa76-12263f7b0494@kot-begemot.co.uk>
Date: Wed, 21 Apr 2021 15:21:21 +0100
MIME-Version: 1.0
In-Reply-To: <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
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
To: linux-um@lists.infradead.org



On 21/04/2021 14:35, YiFei Zhu wrote:
> On Wed, Apr 21, 2021 at 7:32 AM Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>>> Considering that this is a race on the host, what would be the best
>>> way to fix this?
>>
>> Interesting one. I need to think.
>>
>> One option would be to wait for epoll events with a timeout which is larger than zero - f.e. HZ.
> 
> I was about to say I could reproduce it even with a timeout of 1ms,
> then I realized that code I pasted above already used 1ms timeout.
> Assertion failures using 1ms timeout seems much rarer than 0 timeout
> however.
> 
> For reference my CONFIG_HZ on the host is 1000. I also use
> CONFIG_NO_HZ_IDLE if that's relevant (I'm not too familiar with how
> the kernel ticking works).

Reading the code around the kernel the race always applies. What changes is the likelihood.

The usual pattern of doing things is:

1) wake up something - means differ depending on the actual place where this is. This may or may not end up on a different core.

2) send SIGIOs.

The only place which does things the other way around is actually ttys. I had a look there in a couple of places and there it first sends SIGIO, then wakes anyone pending for notifications.

That is why you are seeing it on ttys and that is why we are likely to see this more often on ttys compared to other IO. It will happen on other IO as well as there is no guarantee that the notification handling will be performed on the same core as UML.

As far as using time-out on the poll, there is a number of fds which have lots of spurious SIGIOs and it will end up waiting on them. The worst offender is random, but it is not alone on this one.

This will not be easy - we use epoll with a EPOLLET pattern so if we have missed an event after a SIGIO we will not see it until there is a rerun.

I need to think on this one.

A.


 >
 >
> 
>> If we have received a SIGIO there is an epoll event on the way. The fact that it is not in the queue right now means that we are due to process it shortly.
>>
>> A.
> 
> YiFei Zhu
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

