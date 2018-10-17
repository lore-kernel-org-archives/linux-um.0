Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCprA-0003Gj-Mg
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 17:43:42 +0000
Received: by mail-oi1-x243.google.com with SMTP id 22-v6so21796842oiz.2
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 10:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
In-Reply-To: <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 17 Oct 2018 10:43:17 -0700
Message-ID: <CAFd5g46WZ9A0bDf3G2jkuc=w-hkyk8cMdF=HWzdO8nxNuvjpWA@mail.gmail.com>
Subject: Re: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
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
To: kieran.bingham@ideasonboard.com
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Greg KH <gregkh@linuxfoundation.org>, Tim.Bird@sony.com, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org, Kees Cook <keescook@google.com>, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Wed, Oct 17, 2018 at 8:29 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> I very excitedly jumped on these patches to try them out, as this is
> essentially something I was trying to do a few weeks back.
>
> On 17/10/18 00:50, Brendan Higgins wrote:
> > Makes minimum number of changes outside of the KUnit directories for
> > KUnit to build and run using UML.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Makefile             | 2 +-
> >  arch/um/Kconfig.rest | 3 +++
>
> But this file isn't present on v4.19-rc8
>
> It looks like the file is removed at f163977d21a2 ("um: cleanup Kconfig
> files")

Whoops.

>
> What version have you currently based these patches on?

This patch set is based on 4.18, but I have versions for 4.4, 4.9,
4.14, 4.16, and 4.17.

I will rebase this patch set to 4.19-rc8 and send it out shortly.

> Do you expect to keep a branch somewhere that's easy to pull in?

I have one here: https://kunit-review.googlesource.com/c/linux/+/1030
(you can check it out with git fetch
https://kunit.googlesource.com/linux refs/changes/30/1030/4 && git
checkout FETCH_HEAD)

>
> Please add me to the CC list as an interested party on later versions :-)

Will do.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

