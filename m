Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8rEu-0007XE-7V
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 20:00:34 +0000
Received: by mail-pj1-f65.google.com with SMTP id 12so243935pjb.5
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 12:00:32 -0800 (PST)
Date: Mon, 2 Mar 2020 20:00:27 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 4/7] init: main: add KUnit to kernel init
Message-ID: <20200302200027.GG11244@42.do-not-panic.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130230812.142642-5-brendanhiggins@google.com>
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
Cc: linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, anton.ivanov@cambridgegreys.com, linux-arch@vger.kernel.org, richard@nod.at, knut.omang@oracle.com, rppt@linux.ibm.com, yzaikin@google.com, keescook@chromium.org, arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org, davidgow@google.com, skhan@linuxfoundation.org, kunit-dev@googlegroups.com, alan.maguire@oracle.com, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, logang@deltatee.com

On Thu, Jan 30, 2020 at 03:08:09PM -0800, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

In particular the placement and strategy matches my expectations and
allows us to think of __init as a separate beast, as we should.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

