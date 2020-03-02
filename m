Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8rHx-0007wN-5O
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 20:03:42 +0000
Received: by mail-pj1-f67.google.com with SMTP id m7so259293pjs.0
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 12:03:40 -0800 (PST)
Date: Mon, 2 Mar 2020 20:03:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200302200337.GH11244@42.do-not-panic.com>
References: <20200228012036.15682-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org, sboyd@kernel.org, richard@nod.at, jdike@addtoit.com, linux-doc@vger.kernel.org, linux-um@lists.infradead.org, frowand.list@gmail.com, rppt@linux.ibm.com, logang@deltatee.com, kunit-dev@googlegroups.com, davidgow@google.com, skhan@linuxfoundation.org, akpm@linux-foundation.org, yzaikin@google.com, alan.maguire@oracle.com, linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

Guenter,

are you still running your cross-architecture tests? If so any chance
you can try this for your build tests?

Brendan, do you have this code in a branch which can be merged into
linux-next by any chance?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

