Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iysUO-0005ti-50
 for linux-um@lists.infradead.org; Tue, 04 Feb 2020 07:19:17 +0000
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Mon, 03 Feb 2020 23:19:14 -0800
Message-Id: <20200204071915.AF32B21582@mail.kernel.org>
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

Quoting Brendan Higgins (2020-01-30 15:08:05)
> ## TL;DR
> 
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

Is there any diff from v1 to v2? I don't know what changed, but I see
that my Reviewed-by tag has been put on everything, so I guess
everything I said was addressed or discussed in the previous round.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

