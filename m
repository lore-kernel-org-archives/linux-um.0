Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIdel-0005Lw-PT
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 19:31:41 +0000
Received: by mail-wm1-x341.google.com with SMTP id e9so6933895wme.4
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 12:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200206204018.98f745aed1a1.I986f68ddedf1cb4ef59abf4fbcb5931ce99bc2e8@changeid>
In-Reply-To: <20200206204018.98f745aed1a1.I986f68ddedf1cb4ef59abf4fbcb5931ce99bc2e8@changeid>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 21:31:25 +0200
Message-ID: <CAFLxGvz+vs+zD8=Y+eE1RA=QhkWYPea5R9o5vrhLs3jz4G-wGg@mail.gmail.com>
Subject: Re: [RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules
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
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>, Patricia Alfonso <trishalfonso@google.com>

On Thu, Feb 6, 2020 at 8:40 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> My previous attempt at implementing CONFIG_CONSTRUCTORS failed,
> in part because it was badly done, but also because we just need
> the gcc/libc constructors to run really early for what is really
> a relatively normal userspace program. For some more details, see
> commit 87c9366e1725 ("Revert "um: Enable CONFIG_CONSTRUCTORS"").
>
> On the other hand, we *do* need constructors for modules, if we
> want GCOV_KERNEL (and eventually KASAN) to work there, since the
> constructors that gcc emits will need to be run.
>
> So here's another attempt to implement CONFIG_CONSTRUCTORS: don't
> touch the ones in the main binary, and don't do anything in the
> main init code (do_ctors()), but still allow enabling the symbol
> and associated code for modules.

I have to admit I don't know all details about constructors.
Do I understand this correctly that constructor code is never code which
depends on kernel internals? So it will always be gcc internal stuff?

If so, this approach will work and you can have my:
Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

