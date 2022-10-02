Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 10/14] um: Cleanup compiler warning in arch/x86/um/tls_32.c
Date: Sun,  2 Oct 2022 18:51:51 -0400
Message-Id: <20221002225155.239480-10-sashal@kernel.org>
In-Reply-To: <20221002225155.239480-1-sashal@kernel.org>
References: <20221002225155.239480-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Lukas Straub <lukasstraub2@web.de>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

From: Lukas Straub <lukasstraub2@web.de>

[ Upstream commit d27fff3499671dc23a08efd01cdb8b3764a391c4 ]

arch.tls_array is statically allocated so checking for NULL doesn't
make sense. This causes the compiler warning below.

Remove the checks to silence these warnings.

../arch/x86/um/tls_32.c: In function 'get_free_idx':
../arch/x86/um/tls_32.c:68:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
   68 |         if (!t->arch.tls_array)
      |             ^
In file included from ../arch/x86/um/asm/processor.h:10,
                 from ../include/linux/rcupdate.h:30,
                 from ../include/linux/rculist.h:11,
                 from ../include/linux/pid.h:5,
                 from ../include/linux/sched.h:14,
                 from ../arch/x86/um/tls_32.c:7:
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~
../arch/x86/um/tls_32.c: In function 'get_tls_entry':
../arch/x86/um/tls_32.c:243:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
  243 |         if (!t->arch.tls_array)
      |             ^
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/tls_32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index ac8eee093f9c..66162eafd8e8 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -65,9 +65,6 @@ static int get_free_idx(struct task_struct* task)
 	struct thread_struct *t = &task->thread;
 	int idx;
 
-	if (!t->arch.tls_array)
-		return GDT_ENTRY_TLS_MIN;
-
 	for (idx = 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
 		if (!t->arch.tls_array[idx].present)
 			return idx + GDT_ENTRY_TLS_MIN;
@@ -240,9 +237,6 @@ static int get_tls_entry(struct task_struct *task, struct user_desc *info,
 {
 	struct thread_struct *t = &task->thread;
 
-	if (!t->arch.tls_array)
-		goto clear;
-
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-- 
2.35.1


