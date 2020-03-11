Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jC9ud-0006rX-Tv
 for linux-um@lists.infradead.org; Wed, 11 Mar 2020 22:33:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id 11so3962694wmo.2
 for <linux-um@lists.infradead.org>; Wed, 11 Mar 2020 15:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Wed, 11 Mar 2020 15:32:59 -0700
Message-ID: <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, anton.ivanov@cambridgegreys.com

On Wed, Mar 11, 2020 at 3:32 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > Hi all, I just want to bump this so we can get all the comments while
> > this is still fresh in everyone's minds. I would love if some UML
> > maintainers could give their thoughts!
>
> I'm not the maintainer,
That's okay! I appreciate that you took the time to look at it.

> and I don't know where Richard is, but I just
> tried with the test_kasan.ko module, and that seems to work. Did you
> test that too? I was surprised to see this because you said you didn't
> test modules, but surely this would've been the easiest way?
>
I had not tested with test_kasan.ko. I have been using KUnit to test
KASAN from the beginning so to be completely honest, I hadn't even
learned how to run modules until today.

> Anyway, as expected, stack (and of course alloca) OOB access is not
> detected right now, but otherwise it seems great.
>
Great! Thanks for putting time into this.

> Here's the log:
> https://p.sipsolutions.net/ca9b4157776110fe.txt
>
> I'll repost my module init thing as a proper patch then, I guess.
>
That would be really helpful, thank you!

>
> I do see issues with modules though, e.g.
> https://p.sipsolutions.net/1a2df5f65d885937.txt
>
> where we seem to get some real confusion when lockdep is storing the
> stack trace??
>
> And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
> convinces ASAN that an address is a user address (it might even be
> right?) and it disallows kernel access to it?
>
>
I'll need some time to investigate these all myself. Having just
gotten my first module to run about an hour ago, any more information
about how you got these errors would be helpful so I can try to
reproduce them on my own.

> Also, do you have any intention to work on the stack later? For me,
> enabling that doesn't even report any issues, it just hangs at 'boot'.
>
I was originally planning on it, but it's not a high priority for me
or my team at this time.

> johannes
>

-- 
Best,
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

