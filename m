Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Honggang Li <enjoymindful@gmail.com>
Date: Tue, 12 Aug 2014 21:36:15 +0800
Message-Id: <1407850575-18794-2-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <1407850575-18794-1-git-send-email-enjoymindful@gmail.com>
References: <1407850575-18794-1-git-send-email-enjoymindful@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] Free percpu allocation info for uniprocessor system
To: tj@kernel.org, cl@linux-foundation.org, linux-mm@kvack.org, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Honggang Li <enjoymindful@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Currently, only SMP system free the percpu allocation info.
Uniprocessor system should free it too. For example, one x86 UML
virtual machine with 256MB memory, UML kernel wastes one page memory.

Signed-off-by: Honggang Li <enjoymindful@gmail.com>
---
 mm/percpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 2139e30..da997f9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1932,6 +1932,8 @@ void __init setup_per_cpu_areas(void)
 
 	if (pcpu_setup_first_chunk(ai, fc) < 0)
 		panic("Failed to initialize percpu areas.");
+
+	pcpu_free_alloc_info(ai);
 }
 
 #endif	/* CONFIG_SMP */
-- 
1.8.3.1

