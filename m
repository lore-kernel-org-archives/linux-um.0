Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 17 Mar 2011 12:55:09 -0400
Message-ID: <1300380909.16880.264.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Here, test this patch. I'm in the process of committing it now.
It will be two patches, one for the WARN_ON_SMP() change, the other for
the futex change.

-- Steve

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c2c9ba0..25f1e9e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -168,7 +168,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 #ifdef CONFIG_SMP
 # define WARN_ON_SMP(x)			WARN_ON(x)
 #else
-# define WARN_ON_SMP(x)			do { } while (0)
+# define WARN_ON_SMP(x)			({0;})
 #endif
 
 #endif
diff --git a/kernel/futex.c b/kernel/futex.c
index 9fe9131..850d00b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -785,8 +785,8 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr)
-			|| plist_node_empty(&q->list)))
+	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
+	    || WARN_ON(plist_node_empty(&q->list)))
 		return;
 
 	hb = container_of(q->lock_ptr, struct futex_hash_bucket, lock);


