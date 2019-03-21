Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h6mBi-0004dP-W1
 for linux-um@lists.infradead.org; Thu, 21 Mar 2019 01:08:08 +0000
References: <20190214213729.21702-1-brendanhiggins@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
Date: Wed, 20 Mar 2019 19:07:34 -0600
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Content-Language: en-CA
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
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
To: Brendan Higgins <brendanhiggins@google.com>, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org, kieran.bingham@ideasonboard.com, frowand.list@gmail.com
Cc: brakmo@fb.com, pmladek@suse.com, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

Hi,

On 2019-02-14 2:37 p.m., Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.

I haven't followed the entire conversation but I saw the KUnit write-up
on LWN and ended up, as an exercise, giving it a try.

I really like the idea of having a fast unit testing infrastructure in
the kernel. Occasionally, I write userspace tests for tricky functions
that I essentially write by copying the code over to a throw away C file
and exercise them as I need. I think it would be great to be able to
keep these tests around in a way that they can be run by anyone who
wants to touch the code.

I was just dealing with some functions that required some mocked up
tests so I thought I'd give KUnit a try. I found writing the code very
easy and the infrastructure I was testing was quite simple to mock out
the hardware.

However, I got a bit hung up by one issue: I was writing unit tests for
code in the NTB tree which itself depends on CONFIG_PCI which cannot be
enabled in UML (for what should be obvious reasons). I managed to work
around this because, as luck would have it, all the functions I cared
about testing were actually static inline functions in headers. So I
placed my test code in the kunit folder (so it would compile) and hacked
around a couple a of functions I didn't care about that would not be
compiled.

In the end I got it to work acceptably, but I get the impression that
KUnit will not be usable for wide swaths of kernel code that can't be
compiled in UML. Has there been any discussion or ideas on how to work
around this so it can be more generally useful? Or will this feature be
restricted roughly to non-drivers and functions in headers that don't
have #ifdefs around them?

If you're interested in seeing the unit tests I ended up writing you can
find the commits here[1].

Thanks,

Logan

[1] https://github.com/sbates130272/linux-p2pmem/ ntb_kunit

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

