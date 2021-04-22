Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZXUi-00DcEi-NM
 for linux-um@lists.infradead.org; Thu, 22 Apr 2021 11:27:42 +0000
Subject: Re: Race between SIGIO and epoll from SMP host
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
 <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
 <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
 <ea3cfb8b-3bbd-1ee7-800f-bfb2905869f8@kot-begemot.co.uk>
 <bb88a493-7db5-d508-8a07-bcd80e550347@kot-begemot.co.uk>
 <CABqSeATCv1d+OgaWZwuM4kdLYq-iSei+te3E-wp=SvyTaTYsBg@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c6aeeb7f-8937-b1e7-e1ed-bb5d7d22b961@kot-begemot.co.uk>
Date: Thu, 22 Apr 2021 12:27:34 +0100
MIME-Version: 1.0
In-Reply-To: <CABqSeATCv1d+OgaWZwuM4kdLYq-iSei+te3E-wp=SvyTaTYsBg@mail.gmail.com>
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

On 22/04/2021 09:46, YiFei Zhu wrote:
> On Thu, Apr 22, 2021 at 2:32 AM Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> I now have an idea why we see this on ttys.
>>
>> TTY IO wake-up in addition to doing SIGIO before poll notifications,
>> also does poll notifications using a wake-up which will reschedule.
>>
>> Compared to that, let's say socket does a sync wake-up which does not
>> reschedule and does it before SIGIO.
>>
>> In either case, we stand a chance of missing an interrupt. Just in the
>> second case it is extremely small. So small that I have never seen it in
>> practice.
>>
>> The real way of dealing with it will be to do to do a helper thread
>> which (e)polls the epoll fd and generates a SIGIO if there is an
>> outstanding EPOLL notification which has been missed. This would also
>> take care of the range of conditions which are currently handled by the
>> SIGIO fd helper so that would become surplus to requirements.
>>
>> I think that just polling the epoll fd should do the job here. So this
>> will also get rid of all the motions needed to register fds with the
>> async helper.
>>
>> Brgds,
> 
> By "async helper" do you mean the sigio helper? Is what you are
> suggesting to, in the sigio helper, use epoll instead of using poll,
> and then send SIGIO to notify the kernel thread once epoll receives an
> event? It sounds like a fix, although no idea how difficult it would
> be to efficiently send 'which events have been epolled' back to the
> kernel efficiently without running into races.

The kernel gets the same SIGIO for all devices. The differentiation 
which device received an event is performed by epoll. So this should be 
functionally equivalent to hitting the kernel with SIGIO out of a a 
helper which polls on the epoll fd. If the epoll fd is active 
kill(uml_pid, SIGIO);

This looks like a drop-in fix.

1. Pass the fd for epoll to the helper when the interrupt controller is 
initialized.

2. Remove the ASYNC registration for all FDs.

3. Remove the check for "SIGIO fix in tty".

I will try to get around to PoC this next week. It does not look 
particularly hard.

This will also reduce a lot of spurious interrupts. Some devices (random 
being the worst offender) produce SIGIO for events which are of no 
interest and concern to UML - there is no IO pending.

Will it be faster than enabling the fds for SIGIO - no idea. Need to 
test it.

A.

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

