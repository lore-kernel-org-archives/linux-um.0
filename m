Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSunn-0003pv-QN
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 02:14:41 +0000
Received: by mail-ot1-x329.google.com with SMTP id n8so3059112otl.6
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 18:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com>
 <20181130032924.GH18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130032924.GH18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 30 Nov 2018 18:14:17 -0800
Message-ID: <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
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
To: mcgrof@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, pmladek@suse.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 7:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > A number of test features need to do pretty complicated string printing
> > where it may not be possible to rely on a single preallocated string
> > with parameters.
> >
> > So provide a library for constructing the string as you go similar to
> > C++'s std::string.
>
> Hrm, what's the potential for such thing actually being eventually
> generically useful for printk folks, I wonder? Petr?

Are you saying you think this is applicable for other things? Or are
you saying that you are afraid that somebody might try to use this
elsewhere?

In the former case, this doesn't belong here. In the latter case, it
explicitly depends on KUnit, so it is only available when running
tests.

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

