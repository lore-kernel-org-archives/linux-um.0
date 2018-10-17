Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCuZf-0007Qf-Hg
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 22:45:57 +0000
Received: by mail-ot1-x343.google.com with SMTP id q50so27931364otd.0
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 15:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
 <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 17 Oct 2018 15:45:32 -0700
Message-ID: <CAFd5g47S16XGSt1ecDR1AnfOSuVwr3o7yma99EEG0GkvQ40gzQ@mail.gmail.com>
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

On Wed, Oct 17, 2018 at 2:18 PM <Tim.Bird@sony.com> wrote:
<snip>
> > There are some
> > other features we would like to add which would help with that goal as
> > well like test isolation. We actually have a presubmit server
> > internally for running KUnit tests that can usually respond to patches
> > with test results within a couple minutes. Would something like that
> > be interesting?
> I think the code and architecture of the software that handles presubmit,
> mail-list scanning, notifications, etc. would be of interest.  But KUnit features
> themselves (macro definitions, mocking vs. faking, etc.) would not.
> I only say that in the context of CC-ing the automated testing list on the patch set.
> Of course the KUnit features are interesting by themselves for testers doing
> unit testing.

Fair enough. Well, we will share what we have in that regard, but that
belongs on a separate thread.

BTW, what mailing list is that? I am also guessing your code isn't in
the kernel repo; where is it?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

