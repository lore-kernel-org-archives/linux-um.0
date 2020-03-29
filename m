Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIdke-00071b-25
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 19:37:45 +0000
Message-ID: <07016efc79212aa1b1584b45f3e6bfdbacbfe5c9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 29 Mar 2020 21:37:41 +0200
In-Reply-To: <CAFLxGvw7ucjGr0xv2_KRg3G7jBmL+bv+H3jMqFShFbWpP-xxbg@mail.gmail.com>
 (sfid-20200329_213643_619110_F211A951)
References: <20200206204018.98f745aed1a1.I986f68ddedf1cb4ef59abf4fbcb5931ce99bc2e8@changeid>
 <CAFLxGvz+vs+zD8=Y+eE1RA=QhkWYPea5R9o5vrhLs3jz4G-wGg@mail.gmail.com>
 <738a7f3393e1b161521777e3422513f9b6ac7c7b.camel@sipsolutions.net>
 <CAFLxGvw7ucjGr0xv2_KRg3G7jBmL+bv+H3jMqFShFbWpP-xxbg@mail.gmail.com>
 (sfid-20200329_213643_619110_F211A951)
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, Patricia Alfonso <trishalfonso@google.com>

On Sun, 2020-03-29 at 21:36 +0200, Richard Weinberger wrote:
> On Sun, Mar 29, 2020 at 9:32 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Sun, 2020-03-29 at 21:31 +0200, Richard Weinberger wrote:
> > > On Thu, Feb 6, 2020 at 8:40 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > 
> > > > My previous attempt at implementing CONFIG_CONSTRUCTORS failed,
> > > > in part because it was badly done, but also because we just need
> > > > the gcc/libc constructors to run really early for what is really
> > > > a relatively normal userspace program. For some more details, see
> > > > commit 87c9366e1725 ("Revert "um: Enable CONFIG_CONSTRUCTORS"").
> > > > 
> > > > On the other hand, we *do* need constructors for modules, if we
> > > > want GCOV_KERNEL (and eventually KASAN) to work there, since the
> > > > constructors that gcc emits will need to be run.
> > > > 
> > > > So here's another attempt to implement CONFIG_CONSTRUCTORS: don't
> > > > touch the ones in the main binary, and don't do anything in the
> > > > main init code (do_ctors()), but still allow enabling the symbol
> > > > and associated code for modules.
> > > 
> > > I have to admit I don't know all details about constructors.
> > > Do I understand this correctly that constructor code is never code which
> > > depends on kernel internals? So it will always be gcc internal stuff?
> > 
> > Yeah, more or less. You *can* mark something as
> > __attribute__((constructor)) and the compiler will emit it properly, but
> > that's not really something we do in the kernel.
> 
> Yeah, I grepped for that gcc attribute and didn't find anything because first
> I thought the main use cause of CONFIG_CONSTRUCTORS is supporting
> such things.
> As soon this is the case, UML will fail badly. But this can always happen. ;-)

:)

I think even in the normal kernel many things will fail - it's pretty
early even there.

For now, I think this is fine... Maybe we should remove some of the gcov
hacks though? Haven't looked at that closely.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

