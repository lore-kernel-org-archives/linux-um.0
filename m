Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxJov-0005df-8g
 for linux-um@lists.infradead.org; Mon, 12 Aug 2019 23:33:46 +0000
Received: by mail-pg1-x543.google.com with SMTP id w3so13049443pgt.13
 for <linux-um@lists.infradead.org>; Mon, 12 Aug 2019 16:33:43 -0700 (PDT)
Date: Mon, 12 Aug 2019 16:33:36 -0700
From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
Message-ID: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190812225520.5A67C206A2@mail.kernel.org>
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
To: Stephen Boyd <sboyd@kernel.org>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com, khilman@baylibre.com

On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:06)
> > +void string_stream_clear(struct string_stream *stream)
> > +{
> > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > +
> > +       spin_lock(&stream->lock);
> > +       list_for_each_entry_safe(frag_container,
> > +                                frag_container_safe,
> > +                                &stream->fragments,
> > +                                node) {
> > +               list_del(&frag_container->node);
> 
> Shouldn't we free the allocation here? Otherwise, if some test is going
> to add, add, clear, add, it's going to leak until the test is over?

So basically this means I should add a kunit_kfree and
kunit_resource_destroy (respective equivalents to devm_kfree, and
devres_destroy) and use kunit_kfree here?

> > +       }
> > +       stream->length = 0;
> > +       spin_unlock(&stream->lock);
> > +}
> > +

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

