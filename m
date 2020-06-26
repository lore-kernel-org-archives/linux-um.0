Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 26 Jun 2020 14:20:55 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test
 suites
Message-ID: <202006261420.02E8E62@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-3-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Jun 26, 2020 at 02:09:07PM -0700, Brendan Higgins wrote:
> Add a linker section to arm64 where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 6827da7f3aa54..a1cae9cc655d7 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -181,6 +181,9 @@ SECTIONS
>  		INIT_RAM_FS
>  		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
> +	.kunit_test_suites : {
> +		KUNIT_TEST_SUITES
> +	}

See my reply to 01/12. Then this patch can be dropped. :)

>  	.exit.data : {
>  		EXIT_DATA
>  	}
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

-- 
Kees Cook

