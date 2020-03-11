Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBysg-0005gZ-Uh
 for linux-um@lists.infradead.org; Wed, 11 Mar 2020 10:46:32 +0000
Received: by mail-qt1-x841.google.com with SMTP id e13so1152756qts.6
 for <linux-um@lists.infradead.org>; Wed, 11 Mar 2020 03:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Mar 2020 11:46:10 +0100
Message-ID: <CACT4Y+ZypjEidZQ6E8ajY1yBU6XA2t6eVz56sJ1JaBjCniRMUQ@mail.gmail.com>
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
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Wed, Mar 11, 2020 at 11:32 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > Hi all, I just want to bump this so we can get all the comments while
> > this is still fresh in everyone's minds. I would love if some UML
> > maintainers could give their thoughts!
>
> I'm not the maintainer, and I don't know where Richard is, but I just
> tried with the test_kasan.ko module, and that seems to work. Did you
> test that too? I was surprised to see this because you said you didn't
> test modules, but surely this would've been the easiest way?
>
> Anyway, as expected, stack (and of course alloca) OOB access is not
> detected right now, but otherwise it seems great.
>
> Here's the log:
> https://p.sipsolutions.net/ca9b4157776110fe.txt
>
> I'll repost my module init thing as a proper patch then, I guess.
>
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

Please pass these reports via scripts/decode_stacktrace.sh to add line
numbers (or any other symbolization script). What is the base
revision?
Hard to analyze without line numbers.

> Also, do you have any intention to work on the stack later? For me,
> enabling that doesn't even report any issues, it just hangs at 'boot'.
>
> johannes
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

