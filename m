Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 8 Jul 2020 04:38:23 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Message-ID: <20200708043823.GZ4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
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
Cc: linux-doc@vger.kernel.org, catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org, paulus@samba.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, anton.ivanov@cambridgegreys.com, linux-arch@vger.kernel.org, richard@nod.at, rppt@linux.ibm.com, benh@kernel.crashing.org, yzaikin@google.com, linux-xtensa@linux-xtensa.org, keescook@chromium.org, arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, davidgow@google.com, skhan@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, chris@zankel.net, monstr@monstr.eu, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, logang@deltatee.com, mpe@ellerman.id.au, akpm@linux-foundation.org, alan.maguire@oracle.com

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

The commit log does not explain *why*.

> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

