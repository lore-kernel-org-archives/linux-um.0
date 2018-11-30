Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSjQb-0003BT-Cp
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 14:05:58 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8381D214DE
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 14:05:46 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id z16so5995003qtq.4
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 06:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com>
 <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
 <20181130033704.GL18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130033704.GL18410@garbanzo.do-not-panic.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Nov 2018 08:05:34 -0600
Message-ID: <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
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
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: brakmo@fb.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, knut.omang@oracle.com, Kieran Bingham <kieran.bingham@ideasonboard.com>, Joel Stanley <joel@jms.id.au>, "Bird, Timothy" <Tim.Bird@sony.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Nov 29, 2018 at 9:37 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> > On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Make minimum number of changes outside of the KUnit directories for
> > > KUnit to build and run using UML.
> >
> > There's nothing in this patch limiting this to UML.
>
> Not that one, but the abort thing segv thing is, eventually.
> To support other architectures we'd need to make a wrapper to that
> hack which Brendan added, and then allow each os to implement
> its own call, and add an asm-generic helper.

I've not looked into why this is needed, but can't you make the abort
support optional and arches can select it when they support it. At
least before, the DT unittests didn't need this to run and shouldn't
depend on it after converting to kunit.

Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

