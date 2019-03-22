Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h79FI-0007VK-EL
 for linux-um@lists.infradead.org; Fri, 22 Mar 2019 01:45:21 +0000
Received: by mail-oi1-x243.google.com with SMTP id x188so530373oia.13
 for <linux-um@lists.infradead.org>; Thu, 21 Mar 2019 18:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-17-brendanhiggins@google.com>
 <dd0c4033-183b-9e77-1dee-7c88f62771fa@gmail.com>
In-Reply-To: <dd0c4033-183b-9e77-1dee-7c88f62771fa@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 21 Mar 2019 18:45:08 -0700
Message-ID: <CAFd5g45QnvgyoAGcSQe0E3P1U=qsrRe4uCqXTNCroobmbUH0ng@mail.gmail.com>
Subject: Re: [RFC v4 16/17] of: unittest: split out a couple of test cases
 from unittest
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, "Bird, Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Mar 21, 2019 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Split out a couple of test cases that these features in base.c from the
> > unittest.c monolith. The intention is that we will eventually split out
> > all test cases and group them together based on what portion of device
> > tree they test.
>
> I still object to this patch.  I do not want this code scattered into
> additional files.

Sure, no problem. I will remove this from future revisions.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

