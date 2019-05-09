Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hOsWD-0004st-6t
 for linux-um@lists.infradead.org; Thu, 09 May 2019 23:32:06 +0000
Date: Thu, 9 May 2019 19:30:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509233043.GC20877@mit.edu>
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
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
To: Logan Gunthorpe <logang@deltatee.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, brendanhiggins@google.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com

On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> 
> The second item, arguably, does have significant overlap with kselftest.
> Whether you are running short tests in a light weight UML environment or
> higher level tests in an heavier VM the two could be using the same
> framework for writing or defining in-kernel tests. It *may* also be valuable
> for some people to be able to run all the UML tests in the heavy VM
> environment along side other higher level tests.
> 
> Looking at the selftests tree in the repo, we already have similar items to
> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> 
> However, the number of users of this harness appears to be quite small. Most
> of the code in the selftests tree seems to be a random mismash of scripts
> and userspace code so it's not hard to see it as something completely
> different from the new Kunit:
> 
> $ git grep --files-with-matches kselftest_harness.h *

To the extent that we can unify how tests are written, I agree that
this would be a good thing.  However, you should note that
kselftest_harness.h is currently assums that it will be included in
userspace programs.  This is most obviously seen if you look closely
at the functions defined in the header files which makes calls to
fork(), abort() and fprintf().

So Kunit can't reuse kselftest_harness.h unmodified.  And whether or
not the actual implementation of the header file can be reused or
refactored, making the unit tests use the same or similar syntax would
be a good thing.

Cheers,

						- Ted

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

