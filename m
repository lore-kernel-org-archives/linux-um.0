Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUz9-00DW29-7e
 for linux-um@lists.infradead.org; Thu, 22 Apr 2021 08:46:56 +0000
Received: by mail-pl1-x630.google.com with SMTP id h20so23179202plr.4
 for <linux-um@lists.infradead.org>; Thu, 22 Apr 2021 01:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
 <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
 <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
 <ea3cfb8b-3bbd-1ee7-800f-bfb2905869f8@kot-begemot.co.uk>
 <bb88a493-7db5-d508-8a07-bcd80e550347@kot-begemot.co.uk>
In-Reply-To: <bb88a493-7db5-d508-8a07-bcd80e550347@kot-begemot.co.uk>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Thu, 22 Apr 2021 03:46:43 -0500
Message-ID: <CABqSeATCv1d+OgaWZwuM4kdLYq-iSei+te3E-wp=SvyTaTYsBg@mail.gmail.com>
Subject: Re: Race between SIGIO and epoll from SMP host
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: linux-um@lists.infradead.org

On Thu, Apr 22, 2021 at 2:32 AM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> I now have an idea why we see this on ttys.
>
> TTY IO wake-up in addition to doing SIGIO before poll notifications,
> also does poll notifications using a wake-up which will reschedule.
>
> Compared to that, let's say socket does a sync wake-up which does not
> reschedule and does it before SIGIO.
>
> In either case, we stand a chance of missing an interrupt. Just in the
> second case it is extremely small. So small that I have never seen it in
> practice.
>
> The real way of dealing with it will be to do to do a helper thread
> which (e)polls the epoll fd and generates a SIGIO if there is an
> outstanding EPOLL notification which has been missed. This would also
> take care of the range of conditions which are currently handled by the
> SIGIO fd helper so that would become surplus to requirements.
>
> I think that just polling the epoll fd should do the job here. So this
> will also get rid of all the motions needed to register fds with the
> async helper.
>
> Brgds,

By "async helper" do you mean the sigio helper? Is what you are
suggesting to, in the sigio helper, use epoll instead of using poll,
and then send SIGIO to notify the kernel thread once epoll receives an
event? It sounds like a fix, although no idea how difficult it would
be to efficiently send 'which events have been epolled' back to the
kernel efficiently without running into races.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

