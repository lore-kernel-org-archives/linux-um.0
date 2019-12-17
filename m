Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih7kb-0000wU-Q0
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 07:58:39 +0000
MIME-Version: 1.0
In-Reply-To: <20191216220555.245089-5-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-5-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
Date: Mon, 16 Dec 2019 23:58:36 -0800
Message-Id: <20191217075836.C76942072D@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: linux-arch@vger.kernel.org, knut.omang@oracle.com, gregkh@linuxfoundation.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Quoting Brendan Higgins (2019-12-16 14:05:53)
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

Yes, but why? Is it desired to run the unit tests earlier than opening
the console or something?

> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 978086cfd257d..ca880224c0bab 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
>         return !has_test_failed;
>  }
>  
> -static int kunit_executor_init(void)
> +int kunit_executor_init(void)

Should be marked __init? Even before this patch presumably.

>  {
>         if (kunit_run_all_tests())
>                 return 0;
>         else
>                 return -EFAULT;
>  }
> -
> -late_initcall(kunit_executor_init);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

