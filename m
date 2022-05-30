Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvSvU-004uQ0-GZ
	for linux-um@lists.infradead.org; Mon, 30 May 2022 00:06:29 +0000
Date: Sun, 29 May 2022 17:06:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] mm: Add PAGE_ALIGN_DOWN macro
Message-Id: <20220529170624.0ceefb52ffd2c4496cbe696d@linux-foundation.org>
In-Reply-To: <20220527185600.1236769-1-davidgow@google.com>
References: <20220527185600.1236769-1-davidgow@google.com>
Mime-Version: 1.0
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
To: David Gow <davidgow@google.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org

On Fri, 27 May 2022 11:55:59 -0700 David Gow <davidgow@google.com> wrote:

> This is just the same as PAGE_ALIGN(), but rounds the address down, not
> up.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please include this in the UML tree alongside [2/2].

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

