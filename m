Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 26 Jun 2020 14:33:00 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Message-ID: <202006261431.BB35444FB6@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
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

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

