Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuZjD-0006Fq-9f
	for linux-um@lists.infradead.org; Fri, 27 May 2022 13:10:13 +0000
Received: by mail-lj1-x22f.google.com with SMTP id y28so55418ljd.4
        for <linux-um@lists.infradead.org>; Fri, 27 May 2022 06:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
In-Reply-To: <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 May 2022 15:09:50 +0200
Message-ID: <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
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
Cc: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Brendan Higgins <brendanhiggins@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>

On Fri, 27 May 2022 at 15:05, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2022-05-25 at 18:01 -0700, David Gow wrote:
> > From: Patricia Alfonso <trishalfonso@google.com>
> >
> > Make KASAN run on User Mode Linux on x86_64.
>
> FWIW, I just added this to my virtual lab which I use as CI tests, and
> it immediately found a use-after-free bug in mac80211!
>
> I did note (this is more for kasan-dev@) that the "freed by" is fairly
> much useless when using kfree_rcu(), it might be worthwhile to annotate
> that somehow, so the stack trace is recorded by kfree_rcu() already,
> rather than just showing the RCU callback used for that.

KASAN is doing it for several years now, see e.g.:
https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

