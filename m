Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
 <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
 <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
 <d5dc04ab-9be5-b258-c302-29f8045d6aaa@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <437bc2d1-f26b-0f04-324f-cbdca989e42c@infradead.org>
Date: Mon, 23 Sep 2019 14:30:21 -0700
MIME-Version: 1.0
In-Reply-To: <d5dc04ab-9be5-b258-c302-29f8045d6aaa@kernel.org>
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
To: shuah <shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Linus Torvalds <torvalds@linux-foundation.org>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On 9/23/19 2:18 PM, shuah wrote:

> I would like to apply the series very soon so it gets some soak time
> after this move in linux-next and it can still make the rc1.
> 
> Since there changes can be addressed after rc1, I would like to not
> require Brendan to do another version before I apply.
> 
> Hope you are okay with that Randy!
> 
> thanks,
> -- Shuah

Sure, no problem, go for it .

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

