Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGItv-0008DR-7R
 for linux-um@lists.infradead.org; Thu, 10 Sep 2020 09:29:55 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] um: time-travel: return the sequence number in ACK
 messages
Date: Thu, 10 Sep 2020 11:29:45 +0200
Message-Id: <20200910092945.88677-3-johannes@sipsolutions.net>
In-Reply-To: <20200910092945.88677-1-johannes@sipsolutions.net>
References: <20200910092945.88677-1-johannes@sipsolutions.net>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

For external time travel, the protocol says to return the
incoming sequence number in the ACK message to aid debugging,
so do that.

Change-Id: Ib2bcca1371247b2f8643f35fb85ca5051addd8cc
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index c07436e89e59..3d109ff3309b 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -106,6 +106,7 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		break;
 	}
 
+	resp.seq = msg->seq;
 	os_write_file(time_travel_ext_fd, &resp, sizeof(resp));
 }
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

