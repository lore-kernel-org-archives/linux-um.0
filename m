Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hOY7V-0001Cf-WF
 for linux-um@lists.infradead.org; Thu, 09 May 2019 01:45:18 +0000
Date: Wed, 8 May 2019 21:44:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509014407.GA7031@mit.edu>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com> <20190507172256.GB5900@mit.edu>
 <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On Wed, May 08, 2019 at 05:58:49PM -0700, Frank Rowand wrote:
> 
> If KUnit is added to the kernel, and a subsystem that I am submitting
> code for has chosen to use KUnit instead of kselftest, then yes, I do
> *have* to use KUnit if my submission needs to contain a test for the
> code unless I want to convince the maintainer that somehow my case
> is special and I prefer to use kselftest instead of KUnittest.

That's going to be between you and the maintainer.  Today, if you want
to submit a substantive change to xfs or ext4, you're going to be
asked to create test for that new feature using xfstests.  It doesn't
matter that xfstests isn't in the kernel --- if that's what is
required by the maintainer.

> > supposed to be a simple way to run a large number of small tests that
> > for specific small components in a system.
> 
> kselftest also supports running a subset of tests.  That subset of tests
> can also be a large number of small tests.  There is nothing inherent
> in KUnit vs kselftest in this regard, as far as I am aware.

The big difference is that kselftests are driven by a C program that
runs in userspace.  Take a look at tools/testing/selftests/filesystem/dnotify_test.c
it has a main(int argc, char *argv) function.

In contrast, KUnit are fragments of C code which run in the kernel;
not in userspace.  This allows us to test internal functions inside
complex file system (such as the block allocator in ext4) directly.
This makes it *fundamentally* different from kselftest.

Cheers,

						- Ted

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

