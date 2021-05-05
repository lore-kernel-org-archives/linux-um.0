Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leKTR-004wjC-UT
 for linux-um@lists.infradead.org; Wed, 05 May 2021 16:34:11 +0000
Subject: Re: Potential races in SIGIO vs Epoll order
References: <b1cbe860-4761-f997-74e2-d82e1e084e5b@cambridgegreys.com>
 <CABqSeAQOdYQzzttvYaoakaj5u+kRAKKUrFYv-wAqKLom2m042A@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b9e04230-76da-17f3-e19b-ad60ccaee496@cambridgegreys.com>
Date: Wed, 5 May 2021 17:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <CABqSeAQOdYQzzttvYaoakaj5u+kRAKKUrFYv-wAqKLom2m042A@mail.gmail.com>
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



On 05/05/2021 15:49, YiFei Zhu wrote:
> On Tue, May 4, 2021 at 5:42 AM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>>
>> Hi all,
>>
>> I got around to look at the race discovered by YiFei Zhu in http://lists.infradead.org/pipermail/linux-um/2021-April/001396.html
>>
>> While UML works using an epoll helper to generate SIGIO, it is ~ 5 times slower compared to enabling async IO. So this is not usable as the primary mode of operation for the interrupt controller.
>>
>> I am going to play with it a bit further and try get it to do a "epoll not serviced" check only occasionally - to handle errors and IRQ controller stalls.
>>
>> Brgds,
> 
> This might be a dumb idea (tell me if it is), but what if we still
> have a helper that runs a defferent epoll fd on the exact same set of
> fds as the main thread, and send an additional SIGIO to the main
> thread if it notices an epoll event? This way, a SIGIO is guaranteed
> to be generated after the wake queue is woken up for epoll events.
> What I don't know is if the two different epoll fds will still race in
> the wake queue, if the helper's epoll returns first and sends SIGIO to
> the main thread before the main thread's epoll receives the event...
> Hmm. This would also mean more spurious SIGIOs.

You can poll the epoll fd. It has the same effect.

I tried two approaches.

1. Do not generate SIGIO on fds at all and make the helper thread throw a
SIGIO at the main UML thread every time there is an epoll event. Bombproof,
but slow. Boot time up by a factor of 5.

2. Leave SIGIO on all fds as now and still generate SIGIOs out of the
helper thread - basically throw an extra SIGIO when the epoll becomes
active in the helper. Slow again - very high CPU usage.

There one more option I intend to try next.

We can poll the epollfd on timer events if there is no SIGIO pending in
the signal handler which serves as UML "interrupt hardware". While this
is not a guaranteed approach, there are usually enough active timers in
thesystem to guarantee a check at ~5 milliseconds on average which should
be enough for ttys. It also narrows it down to "only if there is no SIGIO
pending", so there should be no performance penalty if everything works
as it should.

Brgds,


> 
> YiFei Zhu
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

