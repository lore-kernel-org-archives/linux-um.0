Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nua01-0007rw-3l
	for linux-um@lists.infradead.org; Fri, 27 May 2022 13:27:31 +0000
Message-ID: <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 27 May 2022 15:27:23 +0200
In-Reply-To: <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
	 <20220526010111.755166-1-davidgow@google.com>
	 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
	 <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
	 <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
	 <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Brendan Higgins <brendanhiggins@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>

On Fri, 2022-05-27 at 15:18 +0200, Dmitry Vyukov wrote:
> On Fri, 27 May 2022 at 15:15, Johannes Berg <johannes@sipsolutions.net> wrote:
> > 
> > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > > > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > > > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > > > rather than just showing the RCU callback used for that.
> > > 
> > > KASAN is doing it for several years now, see e.g.:
> > > https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ
> > > 
> > 
> > Hm. It didn't for me:
> 
> Please post a full report with line numbers and kernel version.

That was basically it, apart from a few lines snipped from the stack
traces. Kernel version was admittedly a little older - 5.18.0-rc1 + a
few UML fixes + this KASAN patch (+ the fixes I pointed out earlier)

I guess it doesn't really matter that much, just had to dig a bit to
understand why it was freed.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

