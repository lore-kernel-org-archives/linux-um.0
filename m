Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSvhz-00052Y-HA
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 03:12:44 +0000
Received: by mail-pf1-f182.google.com with SMTP id c72so3715556pfc.6
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 19:12:33 -0800 (PST)
Date: Fri, 30 Nov 2018 19:12:28 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
Message-ID: <20181201031228.GM28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com>
 <20181130032924.GH18410@garbanzo.do-not-panic.com>
 <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, pmladek@suse.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Fri, Nov 30, 2018 at 06:14:17PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > > A number of test features need to do pretty complicated string printing
> > > where it may not be possible to rely on a single preallocated string
> > > with parameters.
> > >
> > > So provide a library for constructing the string as you go similar to
> > > C++'s std::string.
> >
> > Hrm, what's the potential for such thing actually being eventually
> > generically useful for printk folks, I wonder? Petr?
> 
> Are you saying you think this is applicable for other things? 

Yes.

> This doesn't belong here.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

