Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55383C79FBF
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MlQ4rFKTwWyoMEkW1u8Rf4R2+/mUltCh0nILf514HPE=; b=bW1Z7gY0Avma11/hJOfYl49TjJ
	3PaC/Rf+JNtyT80pFeNTl6xYhWEDhwkgq0LgN3Ki11GMJ0sCpXLBABWF+M3aQ+OQGnG63CP9KXeyZ
	Y9+mkrecK7h2157zDB+Rud0Qu9ug0rQE08DnyUcn77t1vm+KHBe30k1zLg6eUvN6N1zPjFUgkFHsO
	tUiHFe2sdAryqAPa3wRTmKPovqc2jxiSmm9kL3pxAIy1Ozsg9BbS3R2FtfO6AXkGjWdqmQ33nSMr7
	uodSWholBvrL0RC136P80gtXVOv+kmYFCKpg2fHUKDXtFuDtC6Y1sYdCEWrO4THdsLHCNu10YIqf9
	th5gt9pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gy7-0000000Er9s-0BnK;
	Thu, 10 Sep 2026 15:45:43 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gy4-0000000Er9N-0xSx
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 15:45:41 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c294183384fso296319566b.1
        for <linux-um@lists.infradead.org>; Thu, 10 Sep 2026 08:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789055138; cv=none;
        d=google.com; s=arc-20260327;
        b=EoVP9yixPyz5XWpy1hmX/NgQ7eeSn4BO5LicpUuef0hLgSQc0k3uSPvDnDQnue/3Dy
         zSE9xZJ1HvAuJxJt4a8No6MQ0sO6mGTbd/4OpaeSmGF7l7aPGGt+LO3pRwaNv9XR7IUx
         oj85i5+yXAIE3m2KZPWHtiDBcmfKm3xblLg9zfvKvmpWwf7utv4TXaqRp+Yc5M3n0SFS
         RzZmK91wf0vR136YUhOv4ZDknUuKxxzCviwebvKydZ4WmrI08OXr4DxeK+O+vy8oCMcA
         g1IVMuCWJYtUMVrPB3qP84tvsOyRm53PcflZglWUFpJO56Jd1/Fuh6dYUDOTB+1B8B7p
         kyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MlQ4rFKTwWyoMEkW1u8Rf4R2+/mUltCh0nILf514HPE=;
        fh=D680w6T4GZIOcxRb/Hff7yCM/gyYthCjdkEULuCZgtk=;
        b=IiCFxRkxjNw9iA6JfxTt+7bYnDFNxb1Op0wddF62mPRJ9EkWhMh0c6X5vcYDC3URl/
         z7nS/o5EvAS7j27l+BHY0jc9lv5Q/3P2rUWdbLfYGxHwxV8/eVzCz3kQfCMDnWacbBpw
         P9CtAMNiUZ+DPAv+pTVHvLai2PxZlFv5R4KOTSCHo83PDngzy4vpXugxGRL8/ZjoIcHb
         a94TKQVbZizyyIg/YfHP6IlvjeKV9k+2DEcbiY67NFyPgOKRaONB0EYhLeCtOSQXiUhQ
         Eqd5U/VfHaLYjrMvfBfrnJeIeN93d+KWcksBDUIQH+wEdIqy75sxvyVOGOLxx75XKY87
         Jh2A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789055138; x=1789659938; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlQ4rFKTwWyoMEkW1u8Rf4R2+/mUltCh0nILf514HPE=;
        b=YOQae5HPi+mE0hIagwnvBx56Btzlwlq6891qBHB9ln6pbxe9OzVggX8kz2SWZIOaTe
         WSJ2TXI5i/LBdLR2rUByGdlYp9kpkIIxNituUKo8FwYQZXy/pZcdSXLeEiR0fMnNKIfB
         kHMYGxb3/9Sr0REFamQNqHqqAs82vxNOSfW3YqsvCdXe0wnhEYMSQRu5adrd0V1HxbEp
         esht2t9IwBNrsHKcNHAMBxOHqqN9dVviCXaWx4ZJdBOrKuerX7m0LgyZ6CZO6rXNXeCp
         4MK4Qmq104YYR7KS2n6ronaqWswp5x9XWDxBgYtlJcriY+wywh9p4wNWunbZhDBP9WKn
         e7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055138; x=1789659938;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MlQ4rFKTwWyoMEkW1u8Rf4R2+/mUltCh0nILf514HPE=;
        b=MUUhFW9z6CG5Ep2KBsPvmQgxrG36pEw8oveIWDVRh4tJO9ZTtdjSZEzPOvYRXDqc5c
         S55gehdM3llgp0HS9HUe7zENkN9SbSMYJzyxWze9qA5lGserDcXdNPSfGf6aecc8g7hl
         liCkgikdKaCtBgG2K9Wn/lbGifgEKbd5CTZasJgcWvkOAEB7VftS8bdaSuMCr0vkukdk
         YY03dxGBMR6Ot5wJ4VCdISaCoFwOg3Bgy/e2DtZPclD4urY9zgJiPH+BXwrB2ZbSbPDU
         aaEk0XQAZCH1tmA/K16hCZve2g/Euu+KyCArEMXuylfXCUXlVlw8pu+NC2a7BZ6s7KqE
         sPgA==
X-Gm-Message-State: AFuF++l3gdy53YK3BFQbkr0X9WYxlaEZa9tY22E12dITZ6MprPQVfPwh
	i6WbJ2qqS4hNjnqcWV/9eN+MPun6C96wWWAlFm1mrd7SVAVfRrJMLxT5LYMiMoN+tKW3QzTi1io
	vGafYY481putKNDyzYiaPuDkRdtkdFAk=
X-Gm-Gg: AYBFou28ihhWUSC3d8ug9fOlgIeWlcjaILjoAP6C8zKHDM5ryBn+h4WwrwXhaHevVjN
	c89eQ/fDM3GaLcmHLt2+h9+Xix4TEoRXPgrs3dBeQTB5s0pSCoho6rdOsTaCobOtoMVADIW0HPA
	l8mgmldyF6Ggq8+m6eLOXNCqVnlBeIlWuxPOYUlIrLriteKs8Ex12PSoGQBEMKP7dALO6LRSqAl
	SYiRlCgOtqEFKXLpeF3j99l1wPF9NheQw+BmWKvcD+9g24zgPYwsK1mQsVF7kGVsAvEdXk4813m
	g0sJYmwT8U/HzB0ZW7t/hOE8Q6A95BR8hUjV23rsp8Z3QwtdLCAtnpwRA6+BK12NQGgPCQeSwMY
	GqNZGPFEu90+8sAsgtHQ/uySB2/yEX/EIaOaHiDAAYOBQ7hqd3yyBBccEJwwRMSvh2niT06mgmJ
	epac7AL+GDg3GWB7QjBa6NwQ0Vu9pX+oABkEJSdesJEw==
X-Received: by 2002:a17:907:7a8e:b0:c26:19e3:e97d with SMTP id
 a640c23a62f3a-c2619e3eefbmr1540707066b.29.1789055138082; Thu, 10 Sep 2026
 08:45:38 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?2K3Zhtin2YYg2KfZhNmF2LfZitix2Yo=?= <ha2020anan@gmail.com>
Date: Thu, 10 Sep 2026 18:45:26 +0300
X-Gm-Features: AcwNN1W7ipGTBvTBjeLBQjyXiPRmLzeN_Sk4LWMur1Ju8wfsMqjbFDUxxbJE9eM
Message-ID: <CANai08MgfRTOw3Ryx=QTfkbwu7OyjkWg9UfpWmSw5JVmDWof2Q@mail.gmail.com>
Subject: [PATCH] arch/um: Add security sandboxing by enforcing read-only on
 host system
To: richard@nod.at
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_084540_448625_85BAF188 
X-CRM114-Status: GOOD (  17.17  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

I have developed a security feature for arch/um that protects the host
filesystem. It boots directly from the host system files (making it
fast and lightweight) but enforces a strict Read-Only policy on the
host, while allowing full Read/Write operations only within a specific
sandbox directory (/tmp/sandbox). Any write or modifications outside
this path will be blocked with an -EACCES error.

Since I don't use Git locally, I am sending the configuration, file
path, and explanations directly below. The actual implementation code
is appended at the very bottom of this message.

---

### 1. File Path to Modify:
arch/um/kernel/skas/syscall.c

### 2. How it Works:
- The modified handle_syscall acts as a dynamic firewall for the kernel.
- It intercepts critical file manipulation syscalls (open, openat,
unlink, unlinkat, mkdir, mkdirat, rmdir, rename, renameat, renameat2)
right before execution.
- If a syscall attempts to modify, create, or delete a file, it checks
the path string using strncpy_from_user.
- If the path is absolute and doesn't start with /tmp/sandbox, or if
it contains relative path traversal (..), it rejects the request
instantly by injecting -EACCES into the return register, thus
protecting the underlying host filesystem from any modifications.

### 3. Why the Custom Command and Script are Required:
- **Why the Command is necessary (rootfstype=hostfs):** Traditionally,
UML boots from an isolated disk image (rootfs). By passing this exact
command, we force UML to mount the real host directory (/) as its root
filesystem. This allows the sandbox to boot instantly using the host's
native system binaries and configurations without duplication.
- **Why the Script must be changed:** Since we are booting directly
from the host files, the boot and initialization scripts within the
runtime environment must be adapted to redirect their active system
state, logging, and temporary data writing exclusively into
/tmp/sandbox. If they attempt to write to the regular host paths (like
/var/log or /etc), the kernel security logic will drop the request.

Recommended Kernel Boot Command (Ensure CONFIG_HOSTFS=y is enabled):
./linux root=/dev/root rootfstype=hostfs rootflags=/ init=/sbin/init rw

---

### 4. Implementation Code (Please append this at the end of the file):

// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (C) 2026 Tamim N. Almutairi (Tamimdevlopment@hotmail.com)
 */

#include <linux/kernel.h>
#include <linux/ptrace.h>
#include <linux/seccomp.h>
#include <kern_util.h>
#include <sysdep/ptrace.h>
#include <sysdep/ptrace_user.h>
#include <linux/time-internal.h>
#include <asm/syscall.h>
#include <asm/unistd.h>
#include <asm/delay.h>
#include <linux/fcntl.h>
#include <linux/slab.h>
#include <linux/uaccess.h>

void handle_syscall(struct uml_pt_regs *r)
{
struct pt_regs *regs = container_of(r, struct pt_regs, regs);
int syscall;

UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);

if (syscall_trace_enter(regs))
goto out;

if (!seccomp_permit_syscall())
goto out;

syscall = UPT_SYSCALL_NR(r);

if ((time_travel_mode == TT_MODE_INFCPU ||
    time_travel_mode == TT_MODE_EXTERNAL) &&
   syscall == __NR_sched_yield)
tt_extra_sched_jiffies += 1;

if (syscall >= 0 && syscall < __NR_syscalls) {
unsigned long ret;
int violate_sandbox = 0;

if (syscall == __NR_openat || syscall == __NR_open ||
   syscall == __NR_unlinkat || syscall == __NR_unlink ||
   syscall == __NR_mkdirat || syscall == __NR_mkdir ||
   syscall == __NR_rmdir ||
   syscall == __NR_renameat2 || syscall == __NR_renameat || syscall ==
__NR_rename) {
unsigned long arg_flags = 0;
unsigned long uptr = 0;
unsigned long uptr2 = 0;
int check_path = 0;

if (syscall == __NR_openat) {
uptr = UPT_SYSCALL_ARG2(&regs->regs);
arg_flags = UPT_SYSCALL_ARG3(&regs->regs);
if ((arg_flags & O_ACCMODE) == O_WRONLY ||
   (arg_flags & O_ACCMODE) == O_RDWR ||
   (arg_flags & O_CREAT) ||
   (arg_flags & O_TRUNC)) {
check_path = 1;
}
} else if (syscall == __NR_open) {
uptr = UPT_SYSCALL_ARG1(&regs->regs);
arg_flags = UPT_SYSCALL_ARG2(&regs->regs);
if ((arg_flags & O_ACCMODE) == O_WRONLY ||
   (arg_flags & O_ACCMODE) == O_RDWR ||
   (arg_flags & O_CREAT) ||
   (arg_flags & O_TRUNC)) {
check_path = 1;
}
} else if (syscall == __NR_unlinkat || syscall == __NR_mkdirat) {
uptr = UPT_SYSCALL_ARG2(&regs->regs);
check_path = 1;
} else if (syscall == __NR_renameat2 || syscall == __NR_renameat) {
uptr = UPT_SYSCALL_ARG2(&regs->regs);
uptr2 = UPT_SYSCALL_ARG4(&regs->regs);
check_path = 1;
} else if (syscall == __NR_rename) {
uptr = UPT_SYSCALL_ARG1(&regs->regs);
uptr2 = UPT_SYSCALL_ARG2(&regs->regs);
check_path = 1;
} else {
uptr = UPT_SYSCALL_ARG1(&regs->regs);
check_path = 1;
}

if (check_path && uptr && !violate_sandbox) {
char *kname = kmalloc(256, GFP_KERNEL);
if (kname) {
long res = strncpy_from_user(kname, (const char __user *)uptr, 255);
if (res > 0) {
kname[res] = '\0';
if (kname[0] == '/') {
if (strncmp(kname, "/tmp/sandbox", 12) != 0)
violate_sandbox = 1;
} else {
if (strstr(kname, "..") != NULL)
violate_sandbox = 1;
}
}
kfree(kname);
}
}

if (uptr2 && !violate_sandbox) {
char *kname2 = kmalloc(256, GFP_KERNEL);
if (kname2) {
long res2 = strncpy_from_user(kname2, (const char __user *)uptr2, 255);
if (res2 > 0) {
kname2[res2] = '\0';
if (kname2[0] == '/') {
if (strncmp(kname2, "/tmp/sandbox", 12) != 0)
violate_sandbox = 1;
} else {
if (strstr(kname2, "..") != NULL)
violate_sandbox = 1;
}
}
kfree(kname2);
}
}
}

if (violate_sandbox) {
PT_REGS_SET_SYSCALL_RETURN(regs, -EACCES);
goto out;
}

ret = (*sys_call_table[syscall])(UPT_SYSCALL_ARG1(&regs->regs),
UPT_SYSCALL_ARG2(&regs->regs),
UPT_SYSCALL_ARG3(&regs->regs),
UPT_SYSCALL_ARG4(&regs->regs),
UPT_SYSCALL_ARG5(&regs->regs),
UPT_SYSCALL_ARG6(&regs->regs));

PT_REGS_SET_SYSCALL_RETURN(regs, ret);

if (IS_ERR_VALUE(ret) &&
   (time_travel_mode == TT_MODE_INFCPU ||
    time_travel_mode == TT_MODE_EXTERNAL)) {
um_udelay(1);
schedule();
}
}

out:
syscall_trace_leave(regs);
}

---
Please review this architectural enhancement and let me know your feedback.

Best regards,
Tamim N. Almutairi

