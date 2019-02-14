Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guPAJ-0004xQ-5r
 for linux-um@lists.infradead.org; Thu, 14 Feb 2019 22:07:32 +0000
Received: by mail-ot1-x341.google.com with SMTP id m1so13289172otf.5
 for <linux-um@lists.infradead.org>; Thu, 14 Feb 2019 14:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com>
 <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com>
 <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
 <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com>
 <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
 <eade3052-0aa4-90b4-d55b-8c44556f98bc@ideasonboard.com>
 <CAFd5g46cO_rZYjqKu6CooKcV-uAsCUJjuib38cQv6WHQS3ooaA@mail.gmail.com>
 <20190214172639.GD11489@garbanzo.do-not-panic.com>
In-Reply-To: <20190214172639.GD11489@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 14 Feb 2019 14:07:18 -0800
Message-ID: <CAFd5g46BG=-sjA+ZFz_F-2wEGrD_mhU-W+kHsr1rGsKEv2YtJw@mail.gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brakmo@fb.com, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, "Bird, Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Feb 14, 2019 at 9:26 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 04:17:13PM -0800, Brendan Higgins wrote:
> > On Wed, Feb 13, 2019 at 1:55 PM Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> > Oh, yep, you are right. Does that mean we should bother at all with a defconfig?
>
> If one wanted a qemu enabled type of kernel and also for kuniut one
> could imply run:
>
> make kvmconfig
> make kunitconfig
>
> That would get what you suggest above of default "bells and whistles"
> and keep the kuniut as a fragment.
>
> Hm, actually the kvmconfig doesn't really enable the required fragments
> for qemu, so perhaps one would be good. It would have the serial stuff
> for instance.
>
> > Luis, I know you said you wanted one. I am thinking just stick with
> > the UML one? The downside there is we then get stuck having to
> > maintain the fragment and the defconfig. I right now (in the new
> > revision I am working on) have the Python kunit_tool copy the
> > defconfig if no kunitconfig is provided and a flag is set. It would be
> > pretty straightforward to make it merge in the fragment instead.
>
> Up to you in the end.

I don't really have any opinions on the matter; I don't really use
defconfigs in any of my workflows. So, I just want whatever is easier
for people. The thing that makes the most sense to me would be to
provide a "merge-kunitconfig" option similar to what kselftest does,
but I don't intend on doing that in the initial patchset, unless
someone really thinks that I should do it. So in the meantime, I guess
provide both since that gives people options?

In anycase, I just (finally) sent out v4, so I suggest we continue the
discussion over there.

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

