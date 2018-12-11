Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjET-0002Va-3z
 for linux-um@lists.infradead.org; Tue, 11 Dec 2018 14:41:59 +0000
Date: Tue, 11 Dec 2018 09:41:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181211094140.2a928fe7@gandalf.local.home>
In-Reply-To: <20181211140926.7wzd5jh6klcfsfgz@pathway.suse.cz>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
 <20181206153718.GD24603@bombadil.infradead.org>
 <20181211140926.7wzd5jh6klcfsfgz@pathway.suse.cz>
MIME-Version: 1.0
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
To: Petr Mladek <pmladek@suse.com>
Cc: brakmo@fb.com, Knut Omang <knut.omang@oracle.com>, jeffm@suse.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Sasha Levin <Alexander.Levin@microsoft.com>, Linux Trace Devel <linux-trace-devel@vger.kernel.org>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Eric Sandeen <sandeen@sandeen.net>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Matthew Wilcox <willy@infradead.org>, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, Kent Overstreet <kent.overstreet@gmail.com>, jdike@addtoit.com, Tim.Bird@sony.com, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Eryu Guan <guaneryu@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, joe@perches.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com

On Tue, 11 Dec 2018 15:09:26 +0100
Petr Mladek <pmladek@suse.com> wrote:

> > We have liburcu already, which is good.  The main sticking points are:
> > 
> >  - printk has started adding a lot of %pX enhancements which printf
> >    obviously doesn't know about.  
> 
> I wonder how big problem it is and if it is worth using another
> approach.

No, please do not change the %pX approach.

> 
> An alternative would be to replace them with helper functions
> the would produce the same string. The meaning would be easier
> to understand. But concatenating with the surrounding text
> would be less elegant. People might start using pr_cont()
> that is problematic (mixed lines).
> 
> Also the %pX formats are mostly used to print context of some
> structures. Even the helper functions would need some maintenance
> to keep them compatible.
> 
> BTW: The printk() feature has been introduced 10 years ago by
> the commit 4d8a743cdd2690c0bc8 ("vsprintf: add infrastructure
> support for extended '%p' specifiers").

trace-cmd and perf know about most of the %pX data and how to read it.
Perhaps we can extend the libtraceevent library to export a generic way
to read data from printk() output for other tools to use.

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

