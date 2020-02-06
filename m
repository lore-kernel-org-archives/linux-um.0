Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izmbr-0006RV-2W
 for linux-um@lists.infradead.org; Thu, 06 Feb 2020 19:14:44 +0000
Message-ID: <c264bc73e22be04c5e8422858b8eac97f006f16a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 06 Feb 2020 20:14:31 +0100
In-Reply-To: <CAKFsvUJu7NZpM0ER45zhSzte3ovkAvXBKx3Tppxci7O=0TwJMg@mail.gmail.com>
 (sfid-20200206_192212_045280_EBE78060)
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CAKFsvUJu7NZpM0ER45zhSzte3ovkAvXBKx3Tppxci7O=0TwJMg@mail.gmail.com>
 (sfid-20200206_192212_045280_EBE78060)
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
To: Patricia Alfonso <trishalfonso@google.com>
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, David Gow <davidgow@google.com>, aryabinin@virtuozzo.com, Brendan Higgins <brendanhiggins@google.com>, anton.ivanov@cambridgegreys.com

Hi Patricia,

> I've looked at this quite extensively over the past week or so. I was
> able to initialize KASAN as one of the first things that gets executed
> in main(), but constructors are, in fact, needed before main().

They're called before main, by the dynamic loader, or libc, or whatever
magic is built into the binary, right? But what do you mean by "needed"?

> I
> think it might be best to reintroduce constructors in a limited way to
> allow KASAN to work in UML.

I guess I'd have to see that.

>  I have done as much testing as I can on my
> machine and this limited version seems to work, except when
> STATIC_LINK is set. I will send some patches of what I have done so
> far and we can talk more about it there. I would like to add your
> name, Johannes, as a co-developed-by on that patch. If there is a
> better way to give you credit for this, please let me know.

I think you give me way too much credit, but I'm not going to complain
either way :-)

I'll post in a minute what I had in mind.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

