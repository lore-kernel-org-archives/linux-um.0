Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGVbj-00077a-Kq
 for linux-um@lists.infradead.org; Fri, 04 Oct 2019 21:59:29 +0000
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
From: shuah <shuah@kernel.org>
Message-ID: <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
Date: Fri, 4 Oct 2019 15:59:10 -0600
MIME-Version: 1.0
In-Reply-To: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, robh@kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, jdike@addtoit.com, Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org, shuah <shuah@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tim.Bird@sony.com, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, logang@deltatee.com

On 10/4/19 3:42 PM, Linus Torvalds wrote:
> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>> This question is primarily directed at Shuah and Linus....
>>
>> What's the current status of the kunit series now that Brendan has
>> moved it out of the top-level kunit directory as Linus has requested?
> 

The move happened smack in the middle of merge window and landed in
linux-next towards the end of the merge window.

> We seemed to decide to just wait for 5.5, but there is nothing that
> looks to block that. And I encouraged Shuah to find more kunit cases
> for when it _does_ get merged.
> 

Right. I communicated that to Brendan that we could work on adding more
kunit based tests which would help get more mileage on the kunit.

> So if the kunit branch is stable, and people want to start using it
> for their unit tests, then I think that would be a good idea, and then
> during the 5.5 merge window we'll not just get the infrastructure,
> we'll get a few more users too and not just examples.
> 
thanks,
-- Shuah

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

