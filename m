Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMOjI-0005o0-Os
 for linux-um@lists.infradead.org; Fri, 03 May 2019 03:19:22 +0000
References: <20190501230126.229218-1-brendanhiggins@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ea36c3d6-8c13-2186-16f3-596d834aeebe@deltatee.com>
Date: Thu, 2 May 2019 21:18:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Content-Language: en-US
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
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
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com, gregkh@linuxfoundation.org, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org



On 2019-05-01 5:01 p.m., Brendan Higgins wrote:
> ## TLDR
> 
> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> 5.2.
> 

As I said on the last posting, I like this and would like to see it move
forward. I still have the same concerns over the downsides of using UML
(ie. not being able to compile large swaths of the tree due to features
that don't exist in that arch) but these are concerns for later.

I'd prefer to see the unnecessary indirection that I pointed out in
patch 8 cleaned up but, besides that, the code looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

