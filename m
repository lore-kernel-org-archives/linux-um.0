Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfxp6-0007Hl-SB
 for linux-um@lists.infradead.org; Wed, 26 Jun 2019 02:38:14 +0000
Received: by mail-pl1-f196.google.com with SMTP id e5so503653pls.13
 for <linux-um@lists.infradead.org>; Tue, 25 Jun 2019 19:38:12 -0700 (PDT)
Date: Wed, 26 Jun 2019 02:38:09 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190626023809.GW19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On Wed, Jun 19, 2019 at 06:17:51PM -0700, Frank Rowand wrote:
> It does not matter whether KUnit provides additional things, relative
> to kselftest.  The point I was making is that there appears to be
> _some_ overlap between kselftest and KUnit, and if there is overlap
> then it is worth considering whether the overlap can be unified instead
> of duplicated.

From my experience as an author of several kselftests drivers, one
faily complex, and after reviewing the sysctl kunit test module, I
disagree with this.

Even if there were an overlap, I'd say let the best test harness win.
Just as we have different LSMs that do something similar.

But this is not about that though. Although both are testing code,
they do so in *very* different ways.

The design philosophy and architecture are fundamentally different. The
*only* thing I can think of where there is overlap is that both can test
similar code paths. Beyond that, the layout of how one itemizes tests
could be borrowed, but that would be up to each kselftest author to
decide, in fact some ksefltests do exist which follow similar pattern of
itemizing test cases and running them. Kunit just provides a proper
framework to do this easily but also with a focus on UML. This last
aspect makes kselftests fundamentally orthogonal from an architecture /
design perspective.

After careful review, I cannot personally identify what could be shared
at this point. Can you? If you did identify one part, how do you
recommend to share it?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

