Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1heO48-0002p2-LN
 for linux-um@lists.infradead.org; Fri, 21 Jun 2019 18:15:14 +0000
Date: Fri, 21 Jun 2019 14:13:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190621181342.GA17166@mit.edu>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
 <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
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
To: shuah <shuah@kernel.org>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On Fri, Jun 21, 2019 at 08:59:48AM -0600, shuah wrote:
> > > ### But wait! Doesn't kselftest support in kernel testing?!
> > >
> > > ....
> 
> I think I commented on this before. I agree with the statement that
> there is no overlap between Kselftest and KUnit. I would like see this
> removed. Kselftest module support supports use-cases KUnit won't be able
> to. I can build an kernel with Kselftest test modules and use it in the
> filed to load and run tests if I need to debug a problem and get data
> from a system. I can't do that with KUnit.
> 
> In my mind, I am not viewing this as which is better. Kselftest and
> KUnit both have their place in the kernel development process. It isn't
> productive and/or necessary to comparing Kselftest and KUnit without a
> good understanding of the problem spaces for each of these.
>
> I would strongly recommend not making reference to Kselftest and talk
> about what KUnit offers.

Shuah,

Just to recall the history, this section of the FAQ was added to rebut
the ***very*** strong statements that Frank made that there was
overlap between Kselftest and Kunit, and that having too many ways for
kernel developers to do the identical thing was harmful (he said it
was too much of a burden on a kernel developer) --- and this was an
argument for not including Kunit in the upstream kernel.

If we're past that objection, then perhaps this section can be
dropped, but there's a very good reason why it was there.  I wouldn't
Brendan to be accused of ignoring feedback from those who reviewed his
patches.   :-)

						- Ted

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

