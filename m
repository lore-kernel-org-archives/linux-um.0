Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCt4N-0007yf-0y
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 21:09:32 +0000
Received: by mail-oi1-x244.google.com with SMTP id v69-v6so22308520oif.1
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 14:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 17 Oct 2018 14:09:06 -0700
Message-ID: <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
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
To: Tim.Bird@sony.com
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Greg KH <gregkh@linuxfoundation.org>, jdike@addtoit.com, linux-um@lists.infradead.org, kieran.bingham@ideasonboard.com, rostedt@goodmis.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org, Kees Cook <keescook@google.com>, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Wed, Oct 17, 2018 at 10:52 AM <Tim.Bird@sony.com> wrote:
> >
> > It might be of interest to the automated testing mailing list too ? (Tim?)
>
>  I think this is interesting to groups doing automated testing of the kernel
> (including myself) as another set of tests to run.  Right now I don't see it
> as having any special attributes related to automation.  But I could be wrong.

Pardon my ignorance, but by automated testing you mean a CI server
with presubmits, nightlys, and things of the sort?

If that's the case, KUnit could be helpful because of the low resource
cost in running them and the speed at which they run. There are some
other features we would like to add which would help with that goal as
well like test isolation. We actually have a presubmit server
internally for running KUnit tests that can usually respond to patches
with test results within a couple minutes. Would something like that
be interesting?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

