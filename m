Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwLzD-0006gQ-J3
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 08:12:41 +0000
Subject: Re: [RFC v1 2/2] arch: um: turn BTF_TYPEINFO support off
References: <20200127193549.187419-1-brendanhiggins@google.com>
 <20200127193549.187419-3-brendanhiggins@google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b49a0bf2-eaf7-b2b3-a7f2-db0f280d42ff@cambridgegreys.com>
Date: Tue, 28 Jan 2020 08:12:28 +0000
MIME-Version: 1.0
In-Reply-To: <20200127193549.187419-3-brendanhiggins@google.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, akpm@linux-foundation.org, changbin.du@intel.com, yamada.masahiro@socionext.com, rdunlap@infradead.org, keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, heidifahim@google.com



On 27/01/2020 19:35, Brendan Higgins wrote:
> Currently CONFIG_DEBUG_INFO_BTF=y doesn't work on UML:
> 
> scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> objcopy: --change-section-vma .BTF=0x0000000000000000 never used
> objcopy: --change-section-lma .BTF=0x0000000000000000 never used
> objcopy: error: the input file '.btf.vmlinux.bin' is empty
> Failed to generate BTF for vmlinux
> Try to disable CONFIG_DEBUG_INFO_BTF
> make: *** [Makefile:1078: vmlinux] Error 1
> 
> So turn off ARCH_HAS_BTF_TYPEINFO support off for the UM architecture.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   arch/um/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..53e13d8b210e0 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -6,6 +6,7 @@ config UML
>   	bool
>   	default y
>   	select ARCH_HAS_KCOV
> +	select ARCH_NO_BTF_TYPEINFO
>   	select ARCH_NO_PREEMPT
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_SECCOMP_FILTER
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

