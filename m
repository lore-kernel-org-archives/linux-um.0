Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCA5q-0001eB-SF
 for linux-um@lists.infradead.org; Wed, 11 Mar 2020 22:44:52 +0000
Message-ID: <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 11 Mar 2020 23:44:37 +0100
In-Reply-To: <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 (sfid-20200311_233314_128549_A453E950)
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 (sfid-20200311_233314_128549_A453E950)
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, anton.ivanov@cambridgegreys.com

On Wed, 2020-03-11 at 15:32 -0700, Patricia Alfonso wrote:

> I'll need some time to investigate these all myself. Having just
> gotten my first module to run about an hour ago, any more information
> about how you got these errors would be helpful so I can try to
> reproduce them on my own.

See the other emails, I was basically just loading random modules. In my
case cfg80211, mac80211, mac80211-hwsim - those are definitely available
without any (virtio) hardware requirements, so you could use them.

Note that doing a bunch of vmalloc would likely result in similar
issues, since the module and vmalloc space is the same on UML.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

