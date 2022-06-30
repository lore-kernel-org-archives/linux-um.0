Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6tgv-00HAsI-NY
	for linux-um@lists.infradead.org; Thu, 30 Jun 2022 12:54:43 +0000
Date: Thu, 30 Jun 2022 14:54:34 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
Message-ID: <20220630125434.GA20153@axis.com>
References: <20220630080834.2742777-1-davidgow@google.com>
 <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
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
Cc: David Gow <davidgow@google.com>, Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>

On Thu, Jun 30, 2022 at 11:41:04AM +0200, Dmitry Vyukov wrote:
> On Thu, 30 Jun 2022 at 10:08, David Gow <davidgow@google.com> wrote:
> > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > index 1c2d4b29a3d4..a089217e2f0e 100644
> > --- a/arch/um/kernel/Makefile
> > +++ b/arch/um/kernel/Makefile
> > @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> >  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> >
> > +KASAN_SANITIZE_stacktrace.o := n
> > +KASAN_SANITIZE_sysrq.o := n
> 
> Why are these needed?
> It's helpful to leave some comments for any of *_SANITIZE:=n.
> Otherwise later it's unclear if it's due to some latent bugs, some
> inherent incompatibility, something that can be fixed, etc.

I believe I saw the stacktrace code itself triggering KASAN splats and
causing recursion when sanitization was not disabled on it.  I noticed
that other architectures disabled sanitization of their stacktrace code,
eg. ARM in commit 4d576cab16f57e1f87978f ("ARM: 9028/1: disable KASAN in
call stack capturing routines"), so I did not investigate it further.

(Note that despite the name, sysrq.c is also just stacktrace code.)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

