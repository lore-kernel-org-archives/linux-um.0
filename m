Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFbqO-0006aN-26
 for linux-um@lists.infradead.org; Wed, 02 Oct 2019 10:26:53 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Vector BPF "Firmware" - version 5
Date: Wed,  2 Oct 2019 11:26:44 +0100
Message-Id: <20191002102645.15389-1-anton.ivanov@cambridgegreys.com>
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

I found a bug when testing all possible of up/down and "outer"/"inner"
firmware combinations. It is possible to run end up reading from fs
using the firmware functions with the interrupts enabled and that hits a
BUG().

This is hopefully a final revision of the patch - it now has locking
around the firmware load via ethtool and it has been tested for the various
on/off combinations.

A.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

