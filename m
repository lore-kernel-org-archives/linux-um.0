Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5040B80E.4070809@gmail.com>
Date: Fri, 31 Aug 2012 15:11:42 +0200
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: fix compilation error
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Fix a compilation error due to a regression of commit
d3c1cfcdb43e023ab1b1c7a555cd9e929026500a
"um: pass siginfo to guest process".

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---
  arch/um/os-Linux/time.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index f602385..0748fe0 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -114,7 +114,7 @@ static void deliver_alarm(void)
  	skew += this_tick - last_tick;

  	while (skew >= one_tick) {
-		alarm_handler(SIGVTALRM, NULL);
+		alarm_handler(SIGVTALRM, NULL, NULL);
  		skew -= one_tick;
  	}

-- 
1.7.3.4
