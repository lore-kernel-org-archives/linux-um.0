Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2A7A-0000sA-R1
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 08:44:54 +0000
Received: by mail-qt1-x844.google.com with SMTP id c5so3811343qtj.6
 for <linux-um@lists.infradead.org>; Thu, 13 Feb 2020 00:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
 <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
 <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
 <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
In-Reply-To: <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 13 Feb 2020 09:44:37 +0100
Message-ID: <CACT4Y+ZB3QwzeogxVFVXW_z=eE2n5fQxj7iYq9-Jw68zdS=mUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
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

On Thu, Feb 13, 2020 at 9:19 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-02-12 at 16:37 -0800, Patricia Alfonso wrote:
> >
> > > That also means if I have say 512MB memory allocated for UML, KASAN will
> > > use an *additional* 64, unlike on a "real" system, where KASAN will take
> > > about 1/8th of the available physical memory, right?
> > >
> > Currently, the amount of shadow memory allocated is a constant based
> > on the amount of user space address space in x86_64 since this is the
> > host architecture I have focused on.
>
> Right, but again like below - that's just mapped, not actually used. But
> as far as I can tell, once you actually start running and potentially
> use all of your mem=1024 (MB), you'll actually also use another 128MB on
> the KASAN shadow, right?
>
> Unlike, say, a real x86_64 machine where if you just have 1024 MB
> physical memory, the KASAN shadow will have to fit into that as well.

Depends on what you mean by "real" :)
Real user-space ASAN will also reserve 1/8th of 47-bit VA on start
(16TB). This implementation seems to be much closer to user-space ASAN
rather than to x86_64 KASAN (in particular it seems to be mostly
portable across archs and is not really x86-specific, which is good).
I think it's reasonable and good, but the implementation difference
with other kernel arches may be worth noting somewhere in comments.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

