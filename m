Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIqc-004qQi-5Z
 for linux-um@lists.infradead.org; Wed, 05 May 2021 14:49:59 +0000
Received: by mail-pg1-x536.google.com with SMTP id z16so2002628pga.1
 for <linux-um@lists.infradead.org>; Wed, 05 May 2021 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <b1cbe860-4761-f997-74e2-d82e1e084e5b@cambridgegreys.com>
In-Reply-To: <b1cbe860-4761-f997-74e2-d82e1e084e5b@cambridgegreys.com>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Wed, 5 May 2021 09:49:45 -0500
Message-ID: <CABqSeAQOdYQzzttvYaoakaj5u+kRAKKUrFYv-wAqKLom2m042A@mail.gmail.com>
Subject: Re: Potential races in SIGIO vs Epoll order
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org

On Tue, May 4, 2021 at 5:42 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> Hi all,
>
> I got around to look at the race discovered by YiFei Zhu in http://lists.infradead.org/pipermail/linux-um/2021-April/001396.html
>
> While UML works using an epoll helper to generate SIGIO, it is ~ 5 times slower compared to enabling async IO. So this is not usable as the primary mode of operation for the interrupt controller.
>
> I am going to play with it a bit further and try get it to do a "epoll not serviced" check only occasionally - to handle errors and IRQ controller stalls.
>
> Brgds,

This might be a dumb idea (tell me if it is), but what if we still
have a helper that runs a defferent epoll fd on the exact same set of
fds as the main thread, and send an additional SIGIO to the main
thread if it notices an epoll event? This way, a SIGIO is guaranteed
to be generated after the wake queue is woken up for epoll events.
What I don't know is if the two different epoll fds will still race in
the wake queue, if the helper's epoll returns first and sends SIGIO to
the main thread before the main thread's epoll receives the event...
Hmm. This would also mean more spurious SIGIOs.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

