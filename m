Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV4aE-00019K-GO
 for linux-um@lists.infradead.org; Fri, 07 Dec 2018 01:05:35 +0000
Received: by mail-pf1-f193.google.com with SMTP id c72so1042936pfc.6
 for <linux-um@lists.infradead.org>; Thu, 06 Dec 2018 17:05:22 -0800 (PST)
Date: Thu, 6 Dec 2018 17:05:17 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181207010517.GH28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
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
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: brakmo@fb.com, Knut Omang <knut.omang@oracle.com>, jeffm@suse.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Eric Sandeen <sandeen@sandeen.net>, Matthew Wilcox <willy@infradead.org>, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, Tim.Bird@sony.com, Petr Mladek <pmladek@suse.com>, jdike@addtoit.com, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, fsdevel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>, Eryu Guan <guaneryu@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, joe@perches.com, khilman@baylibre.com

On Thu, Dec 06, 2018 at 12:32:47PM +0000, Kieran Bingham wrote:
> My main initial idea for a libumlinux is to provide infrastructure such
> as our linked-lists and other kernel formatting so that we can take
> kernel code directly to userspace for test and debug (assuming that
> there are no hardware dependencies or things that we can't mock out)

The tools/ directory already does this for a tons of things. Its where
I ended up placing some API I tested a long time ago when I wanted to
test it in userspace, and provide the unit test in userspace (for my
linker table patches).

> Now we just have to start the race to see who can tweak the kernel build
> system to produce an output library first :)

Should be relatively easy if the tools directory used. Yes, there is
an inherent risk of duplication, but that was decided long ago.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

