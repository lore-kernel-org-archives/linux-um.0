Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 26 Jun 2020 14:30:00 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 06/12] arch: xtensa: add linker section for KUnit test
 suites
Message-ID: <202006261429.5F1A1F72BB@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-7-brendanhiggins@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-doc@vger.kernel.org, catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org, paulus@samba.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, anton.ivanov@cambridgegreys.com, linux-arch@vger.kernel.org, richard@nod.at, rppt@linux.ibm.com, benh@kernel.crashing.org, yzaikin@google.com, linux-xtensa@linux-xtensa.org, arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, davidgow@google.com, skhan@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, chris@zankel.net, monstr@monstr.eu, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, alan.maguire@oracle.com, mpe@ellerman.id.au, akpm@linux-foundation.org, logang@deltatee.com
List-ID: <linux-um.lists.infradead.org>

On Fri, Jun 26, 2020 at 02:09:11PM -0700, Brendan Higgins wrote:
> Add a linker section to xtensa where KUnit can put references to its
> test suites. This patch is an early step in transitioning to dispatching
> all KUnit tests from a centralized executor rather than having each as
> its own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/xtensa/kernel/vmlinux.lds.S | 4 ++++

If you ever find yourself modifying multiple arch linker scripts for a
series, something has gone wrong. ;)

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

