Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZF2m-00D0Uv-Qo
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 15:45:40 +0000
Subject: Re: Race between SIGIO and epoll from SMP host
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
 <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
 <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ea3cfb8b-3bbd-1ee7-800f-bfb2905869f8@kot-begemot.co.uk>
Date: Wed, 21 Apr 2021 16:45:31 +0100
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
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-um@lists.infradead.org



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
> 
>> If we have received a SIGIO there is an epoll event on the way. The fact that it is not in the queue right now means that we are due to process it shortly.

This seems to be limited to ttys. Why - I need to figure it out.

If this ends up as tty specific, we can enable the work-around for ttys which was there when they were not producing sigio on write correctly.

This ends up disabled on most modern machines, because modern kernels produce sigio on write correctly for ttys.

With the workaround enabled there is an extra IO event which is produced after the notification appears on the poll loop in a helper thread. So the stall should never happen.

A.

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

