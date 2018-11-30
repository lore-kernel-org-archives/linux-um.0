Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZkK-0006l7-O5
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 03:45:42 +0000
Received: by mail-pf1-f179.google.com with SMTP id c73so2080070pfe.13
 for <linux-um@lists.infradead.org>; Thu, 29 Nov 2018 19:45:30 -0800 (PST)
Date: Thu, 29 Nov 2018 19:45:25 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
Message-ID: <20181130034525.GP18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
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
Cc: brakmo@fb.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, Felix Guo <felixguoxiuping@gmail.com>, joel@jms.id.au, Tim.Bird@sony.com, jdike@addtoit.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> Hi Brendan,
> 
> Please excuse the top posting, but I'm replying here as I'm following
> the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> 
> Could the three line kunitconfig file live under say
> 	 arch/um/configs/kunit_defconfig?
> 
> So that it's always provided? And could even be extended with tests
> which people would expect to be run by default? (say in distributions)

Indeed, and then a top level 'make kunitconfig' could use it as well.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

