Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E9AD12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tp5Cqi0yHYmB2aJoxGy0TuFARNJ6AQlSVSOfXif1f1k=; b=sOT05A3slwis4uE76fUclVbD+m
	dthItKF+nNet/cJsH/N2y+Qc+p1LbJZ6/rpPoaAZ9UlP8gp+PjVe0zEoeaDzCTYNn5LnOG0M56fmW
	xiYFGb/LrkZD0O0PZOyLIcBTHhIjDw1/hSFMGOpOkoYuWEztrstswJzzPOAyzMBOfUiRqx/NtdQ7b
	kOoJ3idmEfyGwBsct9Ux+ZMM0mXo2aQPvGX0dV2+H55j/NP1iL2Dm9tu72KzR7JYFzEmgrzwkpcHn
	uu3h0qgIYjvEfkG85Dd8rr1AuzlJXh5kj34RJ9ox8m6d9pO9qa85yKfBwz40gzncskdFBVh6Fz2DN
	S+pqqlgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuy-0000000GUMe-2iYU;
	Mon, 11 Nov 2024 06:28:56 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuv-0000000GUM4-3c7e
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:55 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-71ec997ad06so3352374b3a.3
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306533; x=1731911333; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp5Cqi0yHYmB2aJoxGy0TuFARNJ6AQlSVSOfXif1f1k=;
        b=Sx2TQv4uYgC09twjReOOTFSt4EY41cyaBuRBDkHQEqY+STMho+HrmAmrjav0WLJT61
         s08iwf3W93kz0c7i9emnn3OvjiZwBjlNvExpeFj6B1LiCrup39qEvC/v5dismy3+EYW8
         hBzEUc+FXSeYlFkxozwZVs1GpnvqvXW8S4j6NVaflD0jrI4N1UCigmFj5MeqNmZ+rZ92
         PHLM97HpAYgq6ux6SWgqxIZ2YVJr5buy/cgg1HIykSjTj+LtFEIPfvX9AO6n2JMW9ijT
         z4wDnn1AGe1mnrT9CiItzdBg0UDWjZz3N+4uspCBKgoevaVMoXoDM5ndFAOcx4qJ113U
         50Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306533; x=1731911333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp5Cqi0yHYmB2aJoxGy0TuFARNJ6AQlSVSOfXif1f1k=;
        b=mdanQguD9FM/vO8jvP0mLoShl2TaTDlQ2bU724Od5UpgEZp5pANM90D0+cAT9vowwM
         ctxv3PDcRorfHid5mrydu+mPhZ7W9IaFLKsTMPKvLB01pP4N0DFrjKWVYmPSUUFg9ZU8
         N0nlzoMS6Z5RTYXyk0R9MBNRCgxdrUY4sGknEpq/vnzK6T2Muw7lz+L6nsX0h3gbKv99
         s9gjQnJhRQ5txqqgIAqOvgCS4DmWo/+nRhKxLj2napp7o5jYrxuksHsXNWAEBjjKloMH
         RSx4Nn/FOB+iBE0G4++jMXEZSLLywk7kluodsYm2AW5zRQtMd/gdgP21dQ9tn/SdZALL
         10Sg==
X-Gm-Message-State: AOJu0YwDAaxrR8I60eOrzT4bBpRCQkac2ivEHsatPP1R7IsjMLLrnrwR
	AR1KD0fLGR3LzDpvJ4z5RfqiyBIm5ktp8eU/LthYfFkrpAD9XX9O
X-Google-Smtp-Source: AGHT+IE6BJzh4ChUkLOUVblIOo7ibr4J0yOxVHpeN5BW2R8C3kfNcIKNYA8u80Gq7FvyRLvXbuc3UQ==
X-Received: by 2002:a05:6a00:21cc:b0:71e:587d:f268 with SMTP id d2e1a72fcca58-724132788e0mr15820601b3a.4.1731306532800;
        Sun, 10 Nov 2024 22:28:52 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f4424adcd7sm4035888a12.69.2024.11.10.22.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:52 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 45EFDDBA92A; Mon, 11 Nov 2024 15:28:50 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 12/13] um: nommu: add documentation of nommu UML
Date: Mon, 11 Nov 2024 15:27:12 +0900
Message-ID: <23a7331dee1536925b940a7857ca891203a240ef.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222853_930929_1DB6DAEF 
X-CRM114-Status: GOOD (  25.51  )
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
 Documentation/virt/uml/nommu-uml.rst | 221 +++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..9172918be137
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,221 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UML has been built with CONFIG_MMU since day 0.  The patchset
+introduces the nommu mode on UML in a different angle from what Linux
+Kernel Library tried.
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
+- when syscalls are issued by userspace, it jumps to `*%rax`, slides
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
+lmbench and (self-crafted) getpid benchmark (with v6.12-rc2 uml/next
+tree).
+
+### lmbench (usec)
+
+||native|um|um-nommu|
+|--|--|--|--|
+|select-10    |0.5644|31.0917|0.2743|
+|select-100   |2.3869|31.4651|1.1472|
+|select-1000  |20.4004|36.4966|9.7533|
+|syscall      |0.1733|25.9904|0.1053|
+|read         |0.3438|27.4873|0.1451|
+|write        |0.2862|25.8794|0.1361|
+|stat         |1.9250|37.5072|0.4532|
+|open/close   |3.8961|65.1736|0.7665|
+|fork+sh      |1173.8889|5404.5000|20577.0000|
+|fork+execve  |535.2105|2179.2000|4716.3333|
+
+### do_getpid bench (nsec)
+
+||native|um|um-nommu|
+|--|--|--|--|
+|getpid | 172 | 25602 | 103|
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
+LD_PRELOAD.  JIT compiler generated code is also generated after execve
+thus, it is not currently translated.
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


