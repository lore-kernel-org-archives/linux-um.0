Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khI4B-0007K0-Po
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 20:04:04 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1khI4A-00DNTC-EO
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 21:04:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v5 0/4] um: suspend/resume support
Date: Mon, 23 Nov 2020 21:03:51 +0100
Message-Id: <20201123200356.297213-1-johannes@sipsolutions.net>
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

I'm tagging this v5 because I had posted the os_idle_sleep() patch
already at v4, the others really are newer. Just to align it all,
as that patch is necessary for the series.

This adds suspend/resume support to ARCH=um, both in regular and
time-travel modes.

The biggest complexity was around how IRQs are handled, and I've
solved that in patch 4 - basically just disables SIGIO for any FD
that shouldn't wake up the system, and then some trickery with the
signal handler to not deliver interrupts while they're still not
enabled again.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

