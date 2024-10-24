Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD02CE8E6D
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OX9wJnkb2HzV9TiCgEkdE1L0JpcCI9YO0cA7DfQN0S0=; b=iiZreAzkJYUvsU0yfp7zs2OhJE
	APftvTbwkERki3cAWWtx927N3gekbTUq/XUNkX8Vk9VNOozsx8TaLupSSRSMH5iZln1R8LKaDuMGg
	Trlx5JSfHpaEZyUR6e8LKVtUUoPf48vmkY81lT92jMrXVi5jKHaLQauf0RKGTg2caGqOVcp30DOHD
	nqxrSeYNq4I149nIqKB4jk+8YNIXbv5WD/sCfZ4Z9qJrHa88X/STUzivDPDm+t8K/wuXOM4/c0w1A
	/97+Ggt14fRGML29TY8qIOUKJcFg9RZGu9tyDR63Q6RiVm3LOPn5YgMUX7K+l5qoAnyFltepO4ny4
	kNQfL4kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wi1-00000000J8n-3y6D;
	Thu, 24 Oct 2024 12:12:57 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfl-00000000Ifx-26u0
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:38 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71f5208217dso518365b3a.2
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771837; x=1730376637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX9wJnkb2HzV9TiCgEkdE1L0JpcCI9YO0cA7DfQN0S0=;
        b=kjircprUKcp+/ok/b4N1X1AatUR4ekVdjJqLAAUgXmsBB43NIAuCgs5weVvU+hl38I
         /6O51iBRAXzXWsywT14UOOY0B1/cbk/0ATc/Qvl296Ev+zQ6KwOLRjkm1X3KyqzE/SKt
         OezLx9ldIGbbo1yidyMbLZWVcoNIzXux6wlqdMweuWCSi+2zTYibsNjnW5giGBcW5LiN
         HlyqynkQPpC9T42NPsH4BIKLCByaP8h/EZrSdn1Z6TFmkW78PB26VG7i35ojciKkZask
         pOUPfT+hflfxglWcHvBRHfsmOjcnVNQ4s0GXqzP9XD+ZtT3H0aSe80SLNDyYndSm78qv
         B0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771837; x=1730376637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX9wJnkb2HzV9TiCgEkdE1L0JpcCI9YO0cA7DfQN0S0=;
        b=R2jc/0vReZkpoN4bEH9k0JlQEKvQU+9JUYLGaHvXqILwc6Y36Q+oNxC+K+aZstdhgv
         PSnLaf0mTamFRJ42OReUG9grEppgqytVr6uCLijfGhjB6kgwh7i2ESmY+g1itimBKWx+
         WsEb9sXqm/DawEGWCyqcdxwrRatL5HWu/6ghymnLdlTUa5focOJGgjqGan/hzK084eYp
         sF6Y+ZFVCUA7DYou0dWTCAUDnRiU3TJkCAA/e7rxVDUmDEY382Ze4shGohRaSUVa7/bT
         dwPmAlRpcX8dJeZg/JWh/bWvhumG6m6Vs5fg/K5ge147QIgMa3DOz9Is5gNdyaYRrtbz
         z4BQ==
X-Gm-Message-State: AOJu0Yw+i2TJ9eiPws9A0Pf1ILZbD5lrFVksjKPpNMw+sfBzM5Yc9Oti
	jZQZByiBk15Rgc0pBOf2tUbys90WFaKSbsVS44RkL3VOkM84fdmR
X-Google-Smtp-Source: AGHT+IFZEd2MMtXW8yzYDRD1VaS9EzEY0bOPPxMyhwTNc2SFCs2CvH4Bz/Cv0TYH2NVXcqLAVAsqvA==
X-Received: by 2002:a05:6a20:b598:b0:1d8:a759:525c with SMTP id adf61e73a8af0-1d989caa57fmr1820460637.39.1729771836814;
        Thu, 24 Oct 2024 05:10:36 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1332f5fsm7834559b3a.49.2024.10.24.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:36 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C5D56D5125F; Thu, 24 Oct 2024 21:10:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 12/13] um: nommu: add documentation of nommu UML
Date: Thu, 24 Oct 2024 21:09:20 +0900
Message-ID: <7ae21ac320c9cd2c38c74c5b08ae5dea916349bb.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051037_567445_29586CAA 
X-CRM114-Status: GOOD (  25.23  )
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

This commit adds an initial documentation for !MMU mode of UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/virt/uml/nommu-uml.rst | 219 +++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..3171f34a50bd
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,219 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UML has been built with CONFIG_MMU since day 0.  The feature
+introduces the nommu mode in a different angle from what Linux Kernel
+Library tried.
+
+.. contents:: :local:
+
+What is it for ?
+================
+
+- Alleviate syscall hook overhead implemented with ptrace(2)
+- To exercises nommu code over UML (and over KUnit)
+- Less dependency to host facilities
+
+
+How it works ?
+==============
+
+To illustrate how this feature works, the below shows how syscalls are
+called under nommu/UML environment.
+
+- boot kernel, setup zpoline trampoline code (detailed later) at address 0x0
+- (userspace starts)
+- calls vfork/execve syscalls
+- during execve, more specifically during load_elf_fdpic_binary()
+  function, kernel translates `syscall/sysenter` instructions with `call
+  *%rax`, which usually point to address 0 to NR_syscalls (around
+  512), where trampoline code was installed during startup.
+- when syscalls are issued by userspace, it jumps to *%rax, slides
+  until `nop` instructions end, and jump to hooked function,
+  `__kernel_vsyscall`, which is an entrypoint for syscall under nommu
+  UML environment.
+- call handler function in sys_call_table[] and follow how UML syscall
+  works.
+- return to userspace
+
+
+What are the differences from MMU-full UML ?
+============================================
+
+The current nommu implementation adds 3 different functions which
+MMU-full UML doesn't have:
+
+- kernel address space can directly be accessible from userspace
+  - so, uaccess() always returns 1
+  - generic implementation of memcpy/strcpy/futex is also used
+- alternate syscall entrypoint without ptrace
+- translation of syscall/sysenter instructions to a trampoline code
+  and syscall hooks
+
+With those modifications, it allows us to use unmodified userspace
+binaries with nommu UML.
+
+
+History
+=======
+
+This feature was originally introduced by Ricardo Koller at Open
+Source Summit NA 2020, then integrated with the syscall translation
+functionality with the clean up to the original code.
+
+Building and run
+================
+
+```
+% make ARCH=um x86_64_nommu_defconfig
+% make ARCH=um
+```
+
+will build UML with CONFIG_MMU=n applied.
+
+Kunit tests can run with the following command:
+
+```
+% ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n
+```
+
+To run a typical Linux distribution, we need nommu-aware userspace.
+We can use a stock version of Alpine Linux with nommu-built version of
+busybox and musl-libc.
+
+
+Preparing root filesystem
+=========================
+
+nommu UML requires to use a specific standard library which is aware
+of nommu kernel.  We have tested custom-build musl-libc and busybox,
+both of which have built-in support for nommu kernels.
+
+There are no available Linux distributions for nommu under x86_64
+architecture, so we need to prepare our own image for the root
+filesystem.  We use Alpine Linux as a base distribution and replace
+busybox and musl-libc on top of that.  The following are the step to
+prepare the filesystem for the quick start.
+
+```
+     container_id=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
+     docker start $container_id
+     docker wait $container_id
+     docker export $container_id > alpine.tar
+     docker rm $container_id
+
+     mnt=$(mktemp -d)
+     dd if=/dev/zero of=alpine.ext4 bs=1 count=0 seek=1G
+     sudo chmod og+wr "alpine.ext4"
+     yes 2>/dev/null | mkfs.ext4 "alpine.ext4" || true
+     sudo mount "alpine.ext4" $mnt
+     sudo tar -xf alpine.tar -C $mnt
+     sudo umount $mnt
+```
+
+This will create a file image, `alpine.ext4`, which contains busybox
+and musl with nommu build on the Alpine Linux root filesystem.  The
+file can be specified to the argument `ubd0=` to the UML command line.
+
+```
+  ./vmlinux eth0=tuntap,tap100,0e:fd:0:0:0:1,172.17.0.1 ubd0=./alpine.ext4 rw mem=1024m loglevel=8 init=/sbin/init
+```
+
+We plan to upstream apk packages for busybox and musl so that we can
+follow the proper procedure to set up the root filesystem.
+
+
+Quick start with docker
+=======================
+
+There is a docker image that you can quickly start with a simple step.
+
+```
+  docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:3.20.3-um-nommu
+```
+
+This will launch a UML instance with an pre-configured root filesystem.
+
+Benchmark
+=========
+
+The below shows an example of performance measurement conducted with
+lmbench and (self-crafted) getpid benchmark (with v6.12-rc3 linus tree).
+
+### lmbench (usec)
+
+||native|um|um-nommu|
+|--|--|--|--|
+|select-10    |0.5645|28.3738|0.2647|
+|select-100   |2.3872|28.8385|1.1021|
+|select-1000  |20.5527|37.6364|9.4264|
+|syscall      |0.1735|26.8711|0.1037|
+|read         |0.3442|28.5771|0.1370|
+|write        |0.2862|28.7340|0.1236|
+|stat         |1.9236|38.5928|0.4640|
+|open/close   |3.8308|66.8451|0.7789|
+|fork+sh      |1176.4444|8221.5000|21443.0000|
+|fork+execve  |533.1053|3034.5000|4894.3333|
+
+### do_getpid bench (nsec)
+
+||native|um|um-nommu|
+|--|--|--|--|
+|getpid | 180 | 31579 | 101|
+
+
+Limitations
+===========
+
+generic nommu limitations
+-------------------------
+Since this port is a kernel of nommu architecture so, the
+implementation inherits the characteristics of other nommu kernels
+(riscv, arm, etc), described below.
+
+- vfork(2) should be used instead of fork(2)
+- ELF loader only loads PIE (position independent executable) binaries
+- processes share the address space among others
+- mmap(2) offers a subset of functionalities (e.g., unsupported
+  MMAP_FIXED)
+
+Thus, we have limited options to userspace programs.  We have tested
+Alpine Linux with musl-libc, which has a support nommu kernel.
+
+access to mmap_min_addr
+----------------------
+As the mechanism of syscall translations relies on an ability to
+write/read memory address zero (0x0), we need to configure host kernel
+with the following command:
+
+```
+% sh -c "echo 0 > /proc/sys/vm/mmap_min_addr"
+```
+
+supported architecture
+----------------------
+The current implementation of nommu UML only works on x86_64 SUBARCH.
+We have not tested with 32-bit environment.
+
+target of syscall translation
+-----------------------------
+The syscall translation only applies to the executable and interpreter
+of ELF binary files which are processed by execve(2) syscall for the
+moment: other libraries such as linked library and dlopen-ed one
+aren't translated; we may be able to trigger the translation by
+LD_PRELOAD.
+
+Note that with musl-libc in Alpine Linux which we've been tested, most
+of syscalls are implemented in the interpreter file
+(ld-musl-x86_64.so) and calling syscall/sysenter instructions from the
+linked/loaded libraries might be rare.  But it is definitely possible
+so, a workaround with LD_PRELOAD is effective.
+
+
+Further readings about NOMMU UML
+================================
+
+- NOMMU UML (original code by Ricardo Koller)
+https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf
+
+- zpoline: syscall translation mechanism
+https://www.usenix.org/conference/atc23/presentation/yasukata
-- 
2.43.0


