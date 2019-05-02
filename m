Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMJ47-0006In-VH
 for linux-um@lists.infradead.org; Thu, 02 May 2019 21:16:29 +0000
Received: by mail-pg1-x543.google.com with SMTP id w22so317195pgi.6
 for <linux-um@lists.infradead.org>; Thu, 02 May 2019 14:16:27 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
Date: Thu, 2 May 2019 14:16:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
Content-Language: en-US
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
To: Brendan Higgins <brendanhiggins@google.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On 5/2/19 11:07 AM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>
>>> The ultimate goal is to create minimal isolated test binaries; in the
>>> meantime we are using UML to provide the infrastructure to run tests, so
>>> define an abstract way to configure and run tests that allow us to
>>> change the context in which tests are built without affecting the user.
>>> This also makes pretty and dynamic error reporting, and a lot of other
>>> nice features easier.
>>>
>>> kunit_config.py:
>>>   - parse .config and Kconfig files.
>>>
>>> kunit_kernel.py: provides helper functions to:
>>>   - configure the kernel using kunitconfig.
>>>   - build the kernel with the appropriate configuration.
>>>   - provide function to invoke the kernel and stream the output back.
>>>
>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>
>> Ah, here's probably my answer to my previous logging format question,
>> right?  What's the chance that these wrappers output stuff in a standard
>> format that test-framework-tools can already parse?  :)
> 
> It should be pretty easy to do. I had some patches that pack up the
> results into a serialized format for a presubmit service; it should be
> pretty straightforward to take the same logic and just change the
> output format.

When examining and trying out the previous versions of the patch I found
the wrappers useful to provide information about how to control and use
the tests, but I had no interest in using the scripts as they do not
fit in with my personal environment and workflow.

In the previous versions of the patch, these helper scripts are optional,
which is good for my use case.  If the helper scripts are required to
get the data into the proper format then the scripts are not quite so
optional, they become the expected environment.  I think the proper
format should exist without the helper scripts.

-Frank

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

