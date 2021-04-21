Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZD1R-00CvBr-IG
 for linux-um@lists.infradead.org; Wed, 21 Apr 2021 13:36:10 +0000
Received: by mail-pf1-x435.google.com with SMTP id c17so28855555pfn.6
 for <linux-um@lists.infradead.org>; Wed, 21 Apr 2021 06:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABqSeARcB3hZZ=qrWCOUSqVnGLcSohzm-L2_8J6BZB+Tsh0zGw@mail.gmail.com>
 <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
In-Reply-To: <d26d976f-2ef0-aeec-e2f4-51b171e0a069@kot-begemot.co.uk>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Wed, 21 Apr 2021 08:35:53 -0500
Message-ID: <CABqSeAQ-UdKoBGvWC-n=020opHDkSKV42c98cb=KvgxHn7gCfw@mail.gmail.com>
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

On Wed, Apr 21, 2021 at 7:32 AM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> > Considering that this is a race on the host, what would be the best
> > way to fix this?
>
> Interesting one. I need to think.
>
> One option would be to wait for epoll events with a timeout which is larger than zero - f.e. HZ.

I was about to say I could reproduce it even with a timeout of 1ms,
then I realized that code I pasted above already used 1ms timeout.
Assertion failures using 1ms timeout seems much rarer than 0 timeout
however.

For reference my CONFIG_HZ on the host is 1000. I also use
CONFIG_NO_HZ_IDLE if that's relevant (I'm not too familiar with how
the kernel ticking works).

> If we have received a SIGIO there is an epoll event on the way. The fact that it is not in the queue right now means that we are due to process it shortly.
>
> A.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

