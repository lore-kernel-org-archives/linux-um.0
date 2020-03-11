Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jByew-0008Lu-QY
 for linux-um@lists.infradead.org; Wed, 11 Mar 2020 10:32:20 +0000
Message-ID: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 11 Mar 2020 11:32:00 +0100
In-Reply-To: <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 (sfid-20200306_010352_481400_662BF174)
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 (sfid-20200306_010352_481400_662BF174)
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
To: Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>
Cc: linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>

Hi,

> Hi all, I just want to bump this so we can get all the comments while
> this is still fresh in everyone's minds. I would love if some UML
> maintainers could give their thoughts!

I'm not the maintainer, and I don't know where Richard is, but I just
tried with the test_kasan.ko module, and that seems to work. Did you
test that too? I was surprised to see this because you said you didn't
test modules, but surely this would've been the easiest way?

Anyway, as expected, stack (and of course alloca) OOB access is not
detected right now, but otherwise it seems great.

Here's the log:
https://p.sipsolutions.net/ca9b4157776110fe.txt

I'll repost my module init thing as a proper patch then, I guess.


I do see issues with modules though, e.g. 
https://p.sipsolutions.net/1a2df5f65d885937.txt

where we seem to get some real confusion when lockdep is storing the
stack trace??

And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
convinces ASAN that an address is a user address (it might even be
right?) and it disallows kernel access to it?


Also, do you have any intention to work on the stack later? For me,
enabling that doesn't even report any issues, it just hangs at 'boot'.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

