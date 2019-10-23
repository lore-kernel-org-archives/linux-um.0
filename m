Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8kg-0001UB-Au
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:12 +0000
Received: by mail-pf1-x442.google.com with SMTP id b4so3191127pfr.12
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:06 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 40/47] Revert "vmlinux.lds.h: remove no-op macro
 VMLINUX_SYMBOL()"
Date: Wed, 23 Oct 2019 13:38:14 +0900
Message-Id: <8e921d04e4efc452f9f6bc05100926df6ef348ee.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

for lkl, mingw32 requires underscore-ed symbols.

This reverts commit a6214385005333202c8cc1744c7075a9e1a26b9a.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 291 +++++++++++++++---------------
 1 file changed, 146 insertions(+), 145 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8c923ca77d56..e5cbf009bc31 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -119,67 +119,67 @@
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
-			__start_mcount_loc = .;			\
+			VMLINUX_SYMBOL(__start_mcount_loc) = .; \
 			KEEP(*(__mcount_loc))			\
-			__stop_mcount_loc = .;
+			VMLINUX_SYMBOL(__stop_mcount_loc) = .;
 #endif
 #else
 #define MCOUNT_REC()
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
-#define LIKELY_PROFILE()	__start_annotated_branch_profile = .;	\
-				KEEP(*(_ftrace_annotated_branch))	\
-				__stop_annotated_branch_profile = .;
+#define LIKELY_PROFILE()	VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
+				*(_ftrace_annotated_branch)			      \
+				VMLINUX_SYMBOL(__stop_annotated_branch_profile) = .;
 #else
 #define LIKELY_PROFILE()
 #endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	__start_branch_profile = .;		\
-				KEEP(*(_ftrace_branch))			\
-				__stop_branch_profile = .;
+#define BRANCH_PROFILE()	VMLINUX_SYMBOL(__start_branch_profile) = .;   \
+				*(_ftrace_branch)			      \
+				VMLINUX_SYMBOL(__stop_branch_profile) = .;
 #else
 #define BRANCH_PROFILE()
 #endif
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
-				__start_kprobe_blacklist = .;		      \
+				VMLINUX_SYMBOL(__start_kprobe_blacklist) = .; \
 				KEEP(*(_kprobe_blacklist))		      \
-				__stop_kprobe_blacklist = .;
+				VMLINUX_SYMBOL(__stop_kprobe_blacklist) = .;
 #else
 #define KPROBE_BLACKLIST()
 #endif
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 #define ERROR_INJECT_WHITELIST()	STRUCT_ALIGN();			      \
-			__start_error_injection_whitelist = .;		      \
+			VMLINUX_SYMBOL(__start_error_injection_whitelist) = .;\
 			KEEP(*(_error_injection_whitelist))		      \
-			__stop_error_injection_whitelist = .;
+			VMLINUX_SYMBOL(__stop_error_injection_whitelist) = .;
 #else
 #define ERROR_INJECT_WHITELIST()
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()	. = ALIGN(8);					\
-			__start_ftrace_events = .;			\
+			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
 			KEEP(*(_ftrace_events))				\
-			__stop_ftrace_events = .;			\
-			__start_ftrace_eval_maps = .;			\
+			VMLINUX_SYMBOL(__stop_ftrace_events) = .;	\
+			VMLINUX_SYMBOL(__start_ftrace_eval_maps) = .;	\
 			KEEP(*(_ftrace_eval_map))			\
-			__stop_ftrace_eval_maps = .;
+			VMLINUX_SYMBOL(__stop_ftrace_eval_maps) = .;
 #else
 #define FTRACE_EVENTS()
 #endif
 
 #ifdef CONFIG_TRACING
-#define TRACE_PRINTKS()	 __start___trace_bprintk_fmt = .;      \
+#define TRACE_PRINTKS() VMLINUX_SYMBOL(__start___trace_bprintk_fmt) = .;      \
 			 KEEP(*(__trace_printk_fmt)) /* Trace_printk fmt' pointer */ \
-			 __stop___trace_bprintk_fmt = .;
-#define TRACEPOINT_STR() __start___tracepoint_str = .;	\
+			 VMLINUX_SYMBOL(__stop___trace_bprintk_fmt) = .;
+#define TRACEPOINT_STR() VMLINUX_SYMBOL(__start___tracepoint_str) = .;	\
 			 KEEP(*(__tracepoint_str)) /* Trace_printk fmt' pointer */ \
-			 __stop___tracepoint_str = .;
+			 VMLINUX_SYMBOL(__stop___tracepoint_str) = .;
 #else
 #define TRACE_PRINTKS()
 #define TRACEPOINT_STR()
@@ -187,27 +187,27 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS() . = ALIGN(8);					\
-			 __start_syscalls_metadata = .;			\
+			 VMLINUX_SYMBOL(__start_syscalls_metadata) = .;	\
 			 KEEP(*(__syscalls_metadata))			\
-			 __stop_syscalls_metadata = .;
+			 VMLINUX_SYMBOL(__stop_syscalls_metadata) = .;
 #else
 #define TRACE_SYSCALLS()
 #endif
 
 #ifdef CONFIG_BPF_EVENTS
 #define BPF_RAW_TP() STRUCT_ALIGN();					\
-			 __start__bpf_raw_tp = .;			\
+			 VMLINUX_SYMBOL(__start__bpf_raw_tp) = .;	\
 			 KEEP(*(__bpf_raw_tp_map))			\
-			 __stop__bpf_raw_tp = .;
+			 VMLINUX_SYMBOL(__stop__bpf_raw_tp) = .;
 #else
 #define BPF_RAW_TP()
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE() . = ALIGN(8);				\
-			 __earlycon_table = .;			\
+			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
-			 __earlycon_table_end = .;
+			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
 #else
 #define EARLYCON_TABLE()
 #endif
@@ -227,7 +227,7 @@
 #define _OF_TABLE_0(name)
 #define _OF_TABLE_1(name)						\
 	. = ALIGN(8);							\
-	__##name##_of_table = .;					\
+	VMLINUX_SYMBOL(__##name##_of_table) = .;			\
 	KEEP(*(__##name##_of_table))					\
 	KEEP(*(__##name##_of_table_end))
 
@@ -241,9 +241,9 @@
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
-	__##name##_acpi_probe_table = .;				\
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	__##name##_acpi_probe_table_end = .;
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
@@ -260,9 +260,9 @@
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
-	__dtb_start = .;						\
+	VMLINUX_SYMBOL(__dtb_start) = .;				\
 	KEEP(*(.dtb.init.rodata))					\
-	__dtb_end = .;
+	VMLINUX_SYMBOL(__dtb_end) = .;
 
 /*
  * .data section
@@ -275,16 +275,16 @@
 	MEM_KEEP(init.data*)						\
 	MEM_KEEP(exit.data*)						\
 	*(.data.unlikely)						\
-	__start_once = .;						\
+	VMLINUX_SYMBOL(__start_once) = .;				\
 	*(.data.once)							\
-	__end_once = .;							\
+	VMLINUX_SYMBOL(__end_once) = .;					\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	__start___verbose = .;						\
+	VMLINUX_SYMBOL(__start___verbose) = .;                          \
 	KEEP(*(__verbose))                                              \
-	__stop___verbose = .;						\
+	VMLINUX_SYMBOL(__stop___verbose) = .;				\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
@@ -296,10 +296,10 @@
  */
 #define NOSAVE_DATA							\
 	. = ALIGN(PAGE_SIZE);						\
-	__nosave_begin = .;						\
+	VMLINUX_SYMBOL(__nosave_begin) = .;				\
 	*(.data..nosave)						\
 	. = ALIGN(PAGE_SIZE);						\
-	__nosave_end = .;
+	VMLINUX_SYMBOL(__nosave_end) = .;
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
@@ -316,19 +316,19 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	__start_init_task = .;						\
-	init_thread_union = .;						\
-	init_stack = .;							\
-	KEEP(*(.data..init_task))					\
-	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_task + THREAD_SIZE;				\
-	__end_init_task = .;
+	VMLINUX_SYMBOL(__start_init_task) = .;				\
+	VMLINUX_SYMBOL(init_thread_union) = .;				\
+	VMLINUX_SYMBOL(init_stack) = .;					\
+	*(.data..init_task)						\
+	*(.data..init_thread_info)					\
+	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
+	VMLINUX_SYMBOL(__end_init_task) = .;
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\
-	__start___jump_table = .;					\
+	VMLINUX_SYMBOL(__start___jump_table) = .;                       \
 	KEEP(*(__jump_table))						\
-	__stop___jump_table = .;
+	VMLINUX_SYMBOL(__stop___jump_table) = .;
 
 /*
  * Allow architectures to handle ro_after_init data on their
@@ -336,10 +336,10 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
-	__start_ro_after_init = .;					\
+	VMLINUX_SYMBOL(__start_ro_after_init) = .;			\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
-	__end_ro_after_init = .;
+	VMLINUX_SYMBOL(__end_ro_after_init) = .;
 #endif
 
 /*
@@ -347,14 +347,14 @@
  */
 #define RO_DATA_SECTION(align)						\
 	. = ALIGN((align));						\
-	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
-		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+	RODATA_SECTION    : AT(ADDR(RODATA_SECTION) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start_rodata) = .;			\
+		*(RODATA_SECTION) *(RODATA_SECTION.*)			\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
-		__start___tracepoints_ptrs = .;				\
+		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-		__stop___tracepoints_ptrs = .;				\
+		VMLINUX_SYMBOL(__stop___tracepoints_ptrs) = .;		\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
 									\
@@ -364,109 +364,109 @@
 									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
-		__start_pci_fixups_early = .;				\
+		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
 		KEEP(*(.pci_fixup_early))				\
-		__end_pci_fixups_early = .;				\
-		__start_pci_fixups_header = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
 		KEEP(*(.pci_fixup_header))				\
-		__end_pci_fixups_header = .;				\
-		__start_pci_fixups_final = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
 		KEEP(*(.pci_fixup_final))				\
-		__end_pci_fixups_final = .;				\
-		__start_pci_fixups_enable = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
 		KEEP(*(.pci_fixup_enable))				\
-		__end_pci_fixups_enable = .;				\
-		__start_pci_fixups_resume = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
 		KEEP(*(.pci_fixup_resume))				\
-		__end_pci_fixups_resume = .;				\
-		__start_pci_fixups_resume_early = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume_early) = .;	\
 		KEEP(*(.pci_fixup_resume_early))			\
-		__end_pci_fixups_resume_early = .;			\
-		__start_pci_fixups_suspend = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume_early) = .;	\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
 		KEEP(*(.pci_fixup_suspend))				\
-		__end_pci_fixups_suspend = .;				\
-		__start_pci_fixups_suspend_late = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend_late) = .;	\
 		KEEP(*(.pci_fixup_suspend_late))			\
-		__end_pci_fixups_suspend_late = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
 	}								\
 									\
 	/* Built-in firmware blobs */					\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
-		__start_builtin_fw = .;					\
+		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
 		KEEP(*(.builtin_fw))					\
-		__end_builtin_fw = .;					\
+		VMLINUX_SYMBOL(__end_builtin_fw) = .;			\
 	}								\
 									\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
-		__start___ksymtab = .;					\
+		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
 		KEEP(*(SORT(___ksymtab+*)))				\
-		__stop___ksymtab = .;					\
+		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
+		VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;		\
 		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
+		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
-		__start___ksymtab_unused = .;				\
+		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
 		KEEP(*(SORT(___ksymtab_unused+*)))			\
-		__stop___ksymtab_unused = .;				\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
-		__start___ksymtab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
 		KEEP(*(SORT(___ksymtab_unused_gpl+*)))			\
-		__stop___ksymtab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
-		__start___ksymtab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
 		KEEP(*(SORT(___ksymtab_gpl_future+*)))			\
-		__stop___ksymtab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		__start___kcrctab = .;					\
+		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
 		KEEP(*(SORT(___kcrctab+*)))				\
-		__stop___kcrctab = .;					\
+		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
+		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
 		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
-		__start___kcrctab_unused = .;				\
+		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
 		KEEP(*(SORT(___kcrctab_unused+*)))			\
-		__stop___kcrctab_unused = .;				\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
-		__start___kcrctab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
 		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
-		__stop___kcrctab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
-		__start___kcrctab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
 		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
-		__stop___kcrctab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
@@ -483,18 +483,18 @@
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
-		__start___param = .;					\
+		VMLINUX_SYMBOL(__start___param) = .;			\
 		KEEP(*(__param))					\
-		__stop___param = .;					\
+		VMLINUX_SYMBOL(__stop___param) = .;			\
 	}								\
 									\
 	/* Built-in module versions. */					\
 	__modver : AT(ADDR(__modver) - LOAD_OFFSET) {			\
-		__start___modver = .;					\
+		VMLINUX_SYMBOL(__start___modver) = .;			\
 		KEEP(*(__modver))					\
-		__stop___modver = .;					\
+		VMLINUX_SYMBOL(__stop___modver) = .;			\
 		. = ALIGN((align));					\
-		__end_rodata = .;					\
+		VMLINUX_SYMBOL(__end_rodata) = .;			\
 	}								\
 	. = ALIGN((align));
 
@@ -524,47 +524,47 @@
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
-		__sched_text_start = .;					\
+		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
-		__sched_text_end = .;
+		VMLINUX_SYMBOL(__sched_text_end) = .;
 
 /* spinlock.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
-		__lock_text_start = .;					\
+		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
-		__lock_text_end = .;
+		VMLINUX_SYMBOL(__lock_text_end) = .;
 
 #define CPUIDLE_TEXT							\
 		ALIGN_FUNCTION();					\
-		__cpuidle_text_start = .;				\
+		VMLINUX_SYMBOL(__cpuidle_text_start) = .;		\
 		*(.cpuidle.text)					\
-		__cpuidle_text_end = .;
+		VMLINUX_SYMBOL(__cpuidle_text_end) = .;
 
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
-		__kprobes_text_start = .;				\
+		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
 		*(.kprobes.text)					\
-		__kprobes_text_end = .;
+		VMLINUX_SYMBOL(__kprobes_text_end) = .;
 
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		__entry_text_start = .;					\
+		VMLINUX_SYMBOL(__entry_text_start) = .;			\
 		*(.entry.text)						\
-		__entry_text_end = .;
+		VMLINUX_SYMBOL(__entry_text_end) = .;
 
 #define IRQENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		__irqentry_text_start = .;				\
+		VMLINUX_SYMBOL(__irqentry_text_start) = .;		\
 		*(.irqentry.text)					\
-		__irqentry_text_end = .;
+		VMLINUX_SYMBOL(__irqentry_text_end) = .;
 
 #define SOFTIRQENTRY_TEXT						\
 		ALIGN_FUNCTION();					\
-		__softirqentry_text_start = .;				\
+		VMLINUX_SYMBOL(__softirqentry_text_start) = .;		\
 		*(.softirqentry.text)					\
-		__softirqentry_text_end = .;
+		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
 
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
@@ -580,9 +580,9 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		__start___ex_table = .;					\
+		VMLINUX_SYMBOL(__start___ex_table) = .;			\
 		KEEP(*(__ex_table))					\
-		__stop___ex_table = .;					\
+		VMLINUX_SYMBOL(__stop___ex_table) = .;			\
 	}
 
 /*
@@ -596,11 +596,11 @@
 
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
-			__ctors_start = .;		   \
+			VMLINUX_SYMBOL(__ctors_start) = .; \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-			__ctors_end = .;
+			VMLINUX_SYMBOL(__ctors_end) = .;
 #else
 #define KERNEL_CTORS()
 #endif
@@ -736,9 +736,9 @@
 #define BUG_TABLE							\
 	. = ALIGN(8);							\
 	__bug_table : AT(ADDR(__bug_table) - LOAD_OFFSET) {		\
-		__start___bug_table = .;				\
+		VMLINUX_SYMBOL(__start___bug_table) = .;		\
 		KEEP(*(__bug_table))					\
-		__stop___bug_table = .;					\
+		VMLINUX_SYMBOL(__stop___bug_table) = .;			\
 	}
 #else
 #define BUG_TABLE
@@ -748,22 +748,22 @@
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		__start_orc_unwind_ip = .;				\
+		VMLINUX_SYMBOL(__start_orc_unwind_ip) = .;		\
 		KEEP(*(.orc_unwind_ip))					\
-		__stop_orc_unwind_ip = .;				\
+		VMLINUX_SYMBOL(__stop_orc_unwind_ip) = .;		\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		__start_orc_unwind = .;					\
+		VMLINUX_SYMBOL(__start_orc_unwind) = .;			\
 		KEEP(*(.orc_unwind))					\
-		__stop_orc_unwind = .;					\
+		VMLINUX_SYMBOL(__stop_orc_unwind) = .;			\
 	}								\
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
-		orc_lookup = .;						\
+		VMLINUX_SYMBOL(orc_lookup) = .;				\
 		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
-		orc_lookup_end = .;					\
+		VMLINUX_SYMBOL(orc_lookup_end) = .;			\
 	}
 #else
 #define ORC_UNWIND_TABLE
@@ -773,9 +773,9 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		__tracedata_start = .;					\
+		VMLINUX_SYMBOL(__tracedata_start) = .;			\
 		KEEP(*(.tracedata))					\
-		__tracedata_end = .;					\
+		VMLINUX_SYMBOL(__tracedata_end) = .;			\
 	}
 #else
 #define TRACEDATA
@@ -783,24 +783,24 @@
 
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		__start_notes = .;					\
-		KEEP(*(.note.*))					\
-		__stop_notes = .;					\
+		VMLINUX_SYMBOL(__start_notes) = .;			\
+		*(.note.*)						\
+		VMLINUX_SYMBOL(__stop_notes) = .;			\
 	}
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		__setup_start = .;					\
+		VMLINUX_SYMBOL(__setup_start) = .;			\
 		KEEP(*(.init.setup))					\
-		__setup_end = .;
+		VMLINUX_SYMBOL(__setup_end) = .;
 
 #define INIT_CALLS_LEVEL(level)						\
-		__initcall##level##_start = .;				\
+		VMLINUX_SYMBOL(__initcall##level##_start) = .;		\
 		KEEP(*(.initcall##level##.init))			\
 		KEEP(*(.initcall##level##s.init))			\
 
 #define INIT_CALLS							\
-		__initcall_start = .;					\
+		VMLINUX_SYMBOL(__initcall_start) = .;			\
 		KEEP(*(.initcallearly.init))				\
 		INIT_CALLS_LEVEL(0)					\
 		INIT_CALLS_LEVEL(1)					\
@@ -811,17 +811,17 @@
 		INIT_CALLS_LEVEL(rootfs)				\
 		INIT_CALLS_LEVEL(6)					\
 		INIT_CALLS_LEVEL(7)					\
-		__initcall_end = .;
+		VMLINUX_SYMBOL(__initcall_end) = .;
 
 #define CON_INITCALL							\
-		__con_initcall_start = .;				\
+		VMLINUX_SYMBOL(__con_initcall_start) = .;		\
 		KEEP(*(.con_initcall.init))				\
-		__con_initcall_end = .;
+		VMLINUX_SYMBOL(__con_initcall_end) = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-	__initramfs_start = .;						\
+	VMLINUX_SYMBOL(__initramfs_start) = .;				\
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
@@ -877,7 +877,7 @@
  * sharing between subsections for different purposes.
  */
 #define PERCPU_INPUT(cacheline)						\
-	__per_cpu_start = .;						\
+	VMLINUX_SYMBOL(__per_cpu_start) = .;				\
 	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
@@ -887,7 +887,7 @@
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
 	PERCPU_DECRYPTED_SECTION					\
-	__per_cpu_end = .;
+	VMLINUX_SYMBOL(__per_cpu_end) = .;
 
 /**
  * PERCPU_VADDR - define output section for percpu area
@@ -914,11 +914,12 @@
  * address, use PERCPU_SECTION.
  */
 #define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
+	VMLINUX_SYMBOL(__per_cpu_load) = .;				\
+	.data..percpu vaddr : AT(VMLINUX_SYMBOL(__per_cpu_load)		\
+				- LOAD_OFFSET) {			\
 		PERCPU_INPUT(cacheline)					\
 	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
+	. = VMLINUX_SYMBOL(__per_cpu_load) + SIZEOF(.data..percpu);
 
 /**
  * PERCPU_SECTION - define output section for percpu area, simple version
@@ -935,7 +936,7 @@
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
+		VMLINUX_SYMBOL(__per_cpu_load) = .;			\
 		PERCPU_INPUT(cacheline)					\
 	}
 
@@ -974,9 +975,9 @@
 #define INIT_TEXT_SECTION(inittext_align)				\
 	. = ALIGN(inittext_align);					\
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {		\
-		_sinittext = .;						\
+		VMLINUX_SYMBOL(_sinittext) = .;				\
 		INIT_TEXT						\
-		_einittext = .;						\
+		VMLINUX_SYMBOL(_einittext) = .;				\
 	}
 
 #define INIT_DATA_SECTION(initsetup_align)				\
@@ -990,8 +991,8 @@
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
 	. = ALIGN(sbss_align);						\
-	__bss_start = .;						\
+	VMLINUX_SYMBOL(__bss_start) = .;				\
 	SBSS(sbss_align)						\
 	BSS(bss_align)							\
 	. = ALIGN(stop_align);						\
-	__bss_stop = .;
+	VMLINUX_SYMBOL(__bss_stop) = .;
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

