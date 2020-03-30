Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIp5h-0007SJ-Jg
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 07:44:15 +0000
Message-ID: <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 30 Mar 2020 09:43:58 +0200
In-Reply-To: <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 (sfid-20200320_161845_514535_9A0BEF71)
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 (sfid-20200320_161845_514535_9A0BEF71)
MIME-Version: 1.0
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> 
> > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > confused the values - because I see, on userspace, the following:
> 
> Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000. 

Right, ok.

> Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...

So it just occurred to me - as I was mentioning this whole thing to
Richard - that there's probably somewhere some check about whether some
space is userspace or not.

I'm beginning to think that we shouldn't just map this outside of the
kernel memory system, but properly treat it as part of the memory that's
inside. And also use KASAN_VMALLOC.

We can probably still have it at 0x7fff8000, just need to make sure we
actually map it? I tried with vm_area_add_early() but it didn't really
work once you have vmalloc() stuff...

I dunno.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

