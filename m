Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hNcuL-0002eC-7H
 for linux-um@lists.infradead.org; Mon, 06 May 2019 12:39:50 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 0/5] arch: um: fixes and virtual time support
Date: Mon,  6 May 2019 14:39:34 +0200
Message-Id: <20190506123939.21091-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi

Here's a respin, with some comments addressed.

I'm also including a patch from Jouni to fix an IRQ controller
regression, since we've been working together a bit on using
this to run hwsim (CONFIG_MAC80211_HWSIM) based tests in UML
virtual time for speedups.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

