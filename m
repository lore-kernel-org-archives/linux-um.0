Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwgog-00038L-Ph
 for linux-um@lists.infradead.org; Wed, 29 Jan 2020 06:27:11 +0000
MIME-Version: 1.0
In-Reply-To: <20200128072002.79250-8-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-8-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
Date: Tue, 28 Jan 2020 22:27:08 -0800
Message-Id: <20200129062709.5B2A22067C@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: linux-arch@vger.kernel.org, knut.omang@oracle.com, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Quoting Brendan Higgins (2020-01-27 23:20:02)
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..0472b02ce16bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>                         0: force disabled
>                         1: force enabled
>  
> +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> +                       running tests.
> +                       Default:        (flag not present) don't shutdown
> +                       poweroff:       poweroff the kernel after running tests.
> +                       halt:           halt the kernel after running tests.
> +                       reboot:         reboot the kernel after running tests.

Maybe drop the full stops on the short descriptions.

Otherwise,

Reviewed-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

