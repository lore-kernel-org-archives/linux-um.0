Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKjWV-00BkvU-KI
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 15:16:21 +0000
From: anton.ivanov@cambridgegreys.com
Subject: Updated performance patch series - resend
Date: Fri, 12 Mar 2021 15:16:06 +0000
Message-Id: <20210312151609.24745-1-anton.ivanov@cambridgegreys.com>
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

Hi all, apologies if some of you will get this twice. Some of the
arguments to git send-email were wrong the first time so some of the
messages bounced.

I have removed the "use glibc strings" patch leaving only xor (needed
for crypto and filesystems), futex (anything multi-threaded) and the
cpu flags transfer from host which is a pre-requisite.

Rationale: prior to the glibc 2.33 which is at least one-two
releases away (next debian will be using 2.31-9), the "hardware
optimized support" in the host glibc is not fully complete. It has
various issues in covering corner cases, etc. As a result the tests are
not fully reproducible and the performance gain is not worth it except
some of the newer Intel CPUs.

It works and there will be clear benefit when various bits and pieces
catch up. We can deal with it then as it will be much easier to
demonstrate.

While at it, there is no point to implement "alternatives" as used
in the kernel at least on newer AMD processors. I applied them to the
various key functions in string.h by hand (by commenting/uncommenting
code) and tested the various combinations.

There is practically no difference. 



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

