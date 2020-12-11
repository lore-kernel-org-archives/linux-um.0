Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUj-0008Ew-CU
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:18 +0000
From: anton.ivanov@cambridgegreys.com
Subject: Amended and retested for 32 bit "borrow ops" series
Date: Fri, 11 Dec 2020 17:45:52 +0000
Message-Id: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org
Cc: richard@nod.at

Hi All,

Apologies for sending a broken version for 32 bit.

This is an amended version which has been tested for 32 bit with/without
glibc "borrowing" and 64 bit with/without glibc borrowing.

It also includes a proper 32 bit futex implementation.

I have combined all patches and bumped the version to no 4.

The total performance difference as measured with dd on a ubd device
which is mostly cached in-memory is ~ 1.3 times for 64 bit and 2.4 times
for 32 bit.

Other benchmarks (find, boot time, etc) benefit as well, but the benefit
is not so drastic.

All tests performed on a Ryzen 5 1600X host.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

