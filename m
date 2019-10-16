Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKe80-0003d7-5Z
 for linux-um@lists.infradead.org; Wed, 16 Oct 2019 07:53:53 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Build fix for VDE and PCAP drivers
Date: Wed, 16 Oct 2019 08:53:42 +0100
Message-Id: <20191016075343.28564-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, 938962@bugs.debian.org

Hi all,

A patch to fix the build for these follows.

I will stick to my original suggestion - pcap should be obsoleted in favour of
vector raw + BPF firmware load. The latter will work on interfaces where gso/gro
is enabled. The original pcap will fail on that due to the 1500 bytes size limit
in the legacy net code.

I had to dig the root cause here and figure out what is going on while working
on an AF_XDP transport as that had the same problem - it needed to pass -lbpf
-lelf -lz which could not be passed under the current build system.

A.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

