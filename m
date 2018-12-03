Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxsq-00042G-Ne
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:44:14 +0000
Received: by mail-pf1-f195.google.com with SMTP id c73so7174884pfe.13
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:44:01 -0800 (PST)
Date: Mon, 3 Dec 2018 15:43:55 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 07/19] kunit: test: add initial tests
Message-ID: <20181203234355.GQ28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-8-brendanhiggins@google.com>
 <20181130034001.GM18410@garbanzo.do-not-panic.com>
 <CAFd5g47CJnfE3Gqc03onidd5FiZSW43-6_dA5czb30-Rb3dyfg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g47CJnfE3Gqc03onidd5FiZSW43-6_dA5czb30-Rb3dyfg@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Mon, Dec 03, 2018 at 03:26:26PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:24AM -0800, Brendan Higgins wrote:
> > > Add a test for string stream along with a simpler example.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  kunit/Kconfig              | 12 ++++++
> > >  kunit/Makefile             |  4 ++
> > >  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
> >
> > BTW if you need another more concrete but very simple example I think it
> > may be possible to port tools/testing/selftests/sysctl/sysctl.sh +
> > lib/test_sysctl.c into a kunit test. Correct me if I'm wrong.
> 
> I think that is pretty doable. I don't know that I want to shoot for
> that on the next revision. But I can definitely do it in a later
> revision, or a later patchset, unless you would strongly prefer it
> now, that is.

No rush on my end, just figured I'd mention a simple candidate in case
you needed another one to evaluate.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

