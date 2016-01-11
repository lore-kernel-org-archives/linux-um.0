Return-Path: <linux-sh-owner@vger.kernel.org>
Date: Mon, 11 Jan 2016 13:00:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 3/3] checkpatch: add virt barriers
Message-ID: <1452509968-19778-4-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Julian Calaby <julian.calaby@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25476c2..c7bf1aa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5133,7 +5133,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			(?:$barriers)|
-			smp_(?:$barrier_stems)
+			smp_(?:$barrier_stems)|
+			virt_(?:$barrier_stems)
 		}x;
 
 		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
-- 
MST

