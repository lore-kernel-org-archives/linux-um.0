Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvN93-004POy-Qj
	for linux-um@lists.infradead.org; Sun, 29 May 2022 17:56:07 +0000
Message-ID: <b65bd540eae2e593f6d9eb21b6c7d9a06a2809fb.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 29 May 2022 19:55:57 +0200
In-Reply-To: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
References: <20220527185600.1236769-1-davidgow@google.com>
	 <20220527185600.1236769-2-davidgow@google.com>
	 <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
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
To: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org

On Fri, 2022-05-27 at 22:14 +0200, Johannes Berg wrote:
> On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> > 
> > This is v2 of the KASAN/UML port. It should be ready to go.
> 
> Nice, thanks a lot! :)
> 
> > It does benefit significantly from the following patches:
> > - Bugfix for memory corruption, needed for KASAN_STACK support:
> > https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
> 
> Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
> 11.3 so far) - is there anything you know about compiler versions
> related to this perhaps? Or clang only?
> 

I do see it on gcc (Debian 10.2.1-6) 10.2.1 20210110, but that was a
different .config too ... strange.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

