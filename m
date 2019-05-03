Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMOfO-0005ep-U0
 for linux-um@lists.infradead.org; Fri, 03 May 2019 03:15:20 +0000
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-9-brendanhiggins@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0a605543-477a-1854-eb35-6e586606889b@deltatee.com>
Date: Thu, 2 May 2019 21:14:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-9-brendanhiggins@google.com>
Content-Language: en-US
Subject: Re: [PATCH v2 08/17] kunit: test: add support for test abort
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
> +/*
> + * struct kunit_try_catch - provides a generic way to run code which might fail.
> + * @context: used to pass user data to the try and catch functions.
> + *
> + * kunit_try_catch provides a generic, architecture independent way to execute
> + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
> + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
> + * is stopped at the site of invocation and @catch is catch is called.

I found some of the C++ comparisons in this series a bit distasteful but
wasn't going to say anything until I saw the try catch.... But looking
into the implementation it's just a thread that can exit early which
seems fine to me. Just a poor choice of name I guess...

[snip]

> +static void __noreturn kunit_abort(struct kunit *test)
> +{
> +	kunit_set_death_test(test, true);
> +
> +	kunit_try_catch_throw(&test->try_catch);
> +
> +	/*
> +	 * Throw could not abort from test.
> +	 *
> +	 * XXX: we should never reach this line! As kunit_try_catch_throw is
> +	 * marked __noreturn.
> +	 */
> +	WARN_ONCE(true, "Throw could not abort from test!\n");
> +}
> +
>  int kunit_init_test(struct kunit *test, const char *name)
>  {
>  	spin_lock_init(&test->lock);
> @@ -77,6 +103,7 @@ int kunit_init_test(struct kunit *test, const char *name)
>  	test->name = name;
>  	test->vprintk = kunit_vprintk;
>  	test->fail = kunit_fail;
> +	test->abort = kunit_abort;

There are a number of these function pointers which seem to be pointless
to me as you only ever set them to one function. Just call the function
directly. As it is, it is an unnecessary indirection for someone reading
the code. If and when you have multiple implementations of the function
then add the pointer. Don't assume you're going to need it later on and
add all this maintenance burden if you never use it..

[snip]

> +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> +{
> +	try_catch->run = kunit_generic_run_try_catch;
> +	try_catch->throw = kunit_generic_throw;
> +}

Same here. There's only one implementation of try_catch and I can't
really see any sensible justification for another implementation. Even
if there is, add the indirection when the second implementation is
added. This isn't C++ and we don't need to make everything a "method".

Thanks,

Logan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

