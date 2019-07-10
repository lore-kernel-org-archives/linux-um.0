Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hl2OO-0001xR-U9
 for linux-um@lists.infradead.org; Wed, 10 Jul 2019 02:31:38 +0000
Date: Tue, 9 Jul 2019 21:31:23 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190710023123.ifnt5osimvzoe5hf@treble>
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190709063023.251446-9-brendanhiggins@google.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, kbuild test robot <lkp@intel.com>, linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com, khilman@baylibre.com

On Mon, Jul 08, 2019 at 11:30:13PM -0700, Brendan Higgins wrote:
> Fix the following warning seen on GCC 7.3:
>   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> 
> kunit_try_catch_throw is a function added in the following patch in this
> series; it allows KUnit, a unit testing framework for the kernel, to
> bail out of a broken test. As a consequence, it is a new __noreturn
> function that objtool thinks is broken (as seen above). So fix this
> warning by adding kunit_try_catch_throw to objtool's noreturn list.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 172f991957269..98db5fe85c797 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"usercopy_abort",
>  		"machine_real_restart",
>  		"rewind_stack_do_exit",
> +		"kunit_try_catch_throw",
>  	};
>  
>  	if (func->bind == STB_WEAK)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

