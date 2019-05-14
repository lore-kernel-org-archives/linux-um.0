Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQgnJ-0007st-Te
 for linux-um@lists.infradead.org; Tue, 14 May 2019 23:25:15 +0000
Received: by mail-pf1-x441.google.com with SMTP id s11so285936pfm.12
 for <linux-um@lists.infradead.org>; Tue, 14 May 2019 16:25:13 -0700 (PDT)
Date: Tue, 14 May 2019 16:25:06 -0700
From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
Message-ID: <20190514232506.GA16788@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-17-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514221711.248228-17-brendanhiggins@google.com>
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
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org, logang@deltatee.com

On Tue, May 14, 2019 at 03:17:09PM -0700, Brendan Higgins wrote:
> Add myself as maintainer of KUnit, the Linux kernel's unit testing
> framework.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c2fce72e694f..8a91887c8d541 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8448,6 +8448,17 @@ S:	Maintained
>  F:	tools/testing/selftests/
>  F:	Documentation/dev-tools/kselftest*
>  
> +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> +M:	Brendan Higgins <brendanhiggins@google.com>
> +L:	linux-kselftest@vger.kernel.org
> +L:	kunit-dev@googlegroups.com
> +W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
> +S:	Maintained
> +F:	Documentation/kunit/

Dang it! I forgot to update the documentation path...

Will fix in next revision.

> +F:	include/kunit/
> +F:	kunit/
> +F:	tools/testing/kunit/
> +
>  KERNEL USERMODE HELPER
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

