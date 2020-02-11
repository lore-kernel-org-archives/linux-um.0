Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Zcx-0006qs-3o
 for linux-um@lists.infradead.org; Tue, 11 Feb 2020 17:47:16 +0000
Received: by mail-wr1-x444.google.com with SMTP id c9so13539734wrw.8
 for <linux-um@lists.infradead.org>; Tue, 11 Feb 2020 09:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
 <CACT4Y+Y=Qj6coWpY107Dj+TsUJK1nruWAC=QMZBDC5snNZRTOw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y=Qj6coWpY107Dj+TsUJK1nruWAC=QMZBDC5snNZRTOw@mail.gmail.com>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Tue, 11 Feb 2020 09:46:59 -0800
Message-ID: <CAKFsvUL=maBVZ7v_N6W1skZRkYm4GacRGn-ohbf-o84p598XNQ@mail.gmail.com>
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Johannes Berg <johannes@sipsolutions.net>, anton.ivanov@cambridgegreys.com

> I started reviewing this, but I am spotting things that I already
> commented on, like shadow start and about shadow size const. Please
> either address them, or answer why they are not addressed, or add some
> kind of TODOs so that I don't write the same comment again.

I'm sorry; They must have gotten lost in all the emails. I'll go
through them all again.
-- 
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

