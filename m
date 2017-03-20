Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 01/10] x86/msr: Rename MISC_FEATURE_ENABLES to MISC_FEATURES_ENABLES
Date: Mon, 20 Mar 2017 01:16:19 -0700
Message-Id: <20170320081628.18952-2-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This matches the only public Intel documentation of this MSR, in the
"Virtualization Technology FlexMigration Application Note"
(preserved at https://bugzilla.kernel.org/attachment.cgi?id=243991)

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/include/asm/msr-index.h | 6 +++---
 arch/x86/kernel/cpu/intel.c      | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4c928f332f8f..f429b70ebaef 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -553,10 +553,10 @@
 #define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT	39
 #define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT)
 
-/* MISC_FEATURE_ENABLES non-architectural features */
-#define MSR_MISC_FEATURE_ENABLES	0x00000140
+/* MISC_FEATURES_ENABLES non-architectural features */
+#define MSR_MISC_FEATURES_ENABLES	0x00000140
 
-#define MSR_MISC_FEATURE_ENABLES_RING3MWAIT_BIT		1
+#define MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT	1
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 063197771b8d..e229318d7230 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -91,13 +91,13 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
 	}
 
 	if (ring3mwait_disabled) {
-		msr_clear_bit(MSR_MISC_FEATURE_ENABLES,
-			      MSR_MISC_FEATURE_ENABLES_RING3MWAIT_BIT);
+		msr_clear_bit(MSR_MISC_FEATURES_ENABLES,
+			      MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT);
 		return;
 	}
 
-	msr_set_bit(MSR_MISC_FEATURE_ENABLES,
-		    MSR_MISC_FEATURE_ENABLES_RING3MWAIT_BIT);
+	msr_set_bit(MSR_MISC_FEATURES_ENABLES,
+		    MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT);
 
 	set_cpu_cap(c, X86_FEATURE_RING3MWAIT);
 
-- 
2.11.0


