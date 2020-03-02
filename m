Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8sQd-0000fA-Jz
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 21:16:44 +0000
Received: by mail-pj1-x1044.google.com with SMTP id 12so328154pjb.5
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 13:16:42 -0800 (PST)
Date: Mon, 2 Mar 2020 13:16:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200302211640.GA8364@roeck-us.net>
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302200337.GH11244@42.do-not-panic.com>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, anton.ivanov@cambridgegreys.com, linux-arch@vger.kernel.org, richard@nod.at, rppt@linux.ibm.com, yzaikin@google.com, keescook@chromium.org, arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org, davidgow@google.com, skhan@linuxfoundation.org, kunit-dev@googlegroups.com, alan.maguire@oracle.com, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, logang@deltatee.com

On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> Guenter,
> 
> are you still running your cross-architecture tests? If so any chance

Yes

> you can try this for your build tests?
> 

I didn't have KUNIT_TEST enabled to start with. I did that now, and
started a test run on mainline a minute ago. We'll see how that goes.

Afterwards, sure, I can run the series in a test branch. It would be great
if I can pick it up from a repository somewhere.

Guenter

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

