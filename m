Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hftgu-00007k-3M
 for linux-um@lists.infradead.org; Tue, 25 Jun 2019 22:13:29 +0000
Received: by mail-pg1-f193.google.com with SMTP id w10so119048pgj.7
 for <linux-um@lists.infradead.org>; Tue, 25 Jun 2019 15:13:21 -0700 (PDT)
Date: Tue, 25 Jun 2019 22:13:18 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
Message-ID: <20190625221318.GO19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-7-brendanhiggins@google.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com, khilman@baylibre.com

On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"

This patch would break compilation as kunit/Kconfig is not introduced. This
would would also break bisectability on this commit. This change should
either be folded in to the next patch, or just be a separate patch after
the next one.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

