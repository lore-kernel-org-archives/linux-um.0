Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosNG-0006IL-3e
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 18:15:07 +0000
From: anton.ivanov@cambridgegreys.com
Subject: Updated performance patch series
Date: Mon, 14 Dec 2020 18:14:55 +0000
Message-Id: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
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

1. I have revised the patches to fallback to x86 throughout instead
of falling back to generics.
2. Symlinks have been dropped in favour of direct references for the
x86 includes where applicable.
3. We use x86 CPU Feature flags now so anyone who wants to try their
luck doing the alternatives replacement can reuse some of the x86 code.
4. The perf gap between using kernel functions and using glibc has
narrowed a bit, but it is still there.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

