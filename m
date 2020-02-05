Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz8PN-0003Uv-87
 for linux-um@lists.infradead.org; Wed, 05 Feb 2020 00:19:10 +0000
Received: by mail-yw1-xc44.google.com with SMTP id i126so749211ywe.7
 for <linux-um@lists.infradead.org>; Tue, 04 Feb 2020 16:19:09 -0800 (PST)
Subject: Re: [PATCH v2 7/7] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-8-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d187686e-a175-e30b-2af9-6e00822fed5c@gmail.com>
Date: Tue, 4 Feb 2020 18:19:07 -0600
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-8-brendanhiggins@google.com>
Content-Language: en-US
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
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org, knut.omang@oracle.com, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, kunit-dev@googlegroups.com

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..522fd8bdec949 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>  			0: force disabled
>  			1: force enabled
>  
> +	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> +			running tests.

                        running built-in tests.  Tests configured as modules will not be run.

My wording might not be consistent with KUnit terminology regarding "built-in" and "modules".
Feel free to properly word smith.


> +			Default:	(flag not present) don't shutdown
> +			poweroff:	poweroff the kernel after running tests
> +			halt:		halt the kernel after running tests
> +			reboot:		reboot the kernel after running tests
> +
>  	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>  			Default is 0 (don't ignore, but inject #GP)
>  
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

