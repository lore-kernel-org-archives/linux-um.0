Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2D2E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tXQSNMgJqzof335xyb+wQpRamNOgF+00bnDFWmwyFUg=; b=mH02sa2BUErKJiymiRaq7v/OGh
	t+GTeuAc6UQkMBB4edEzwls3HXQ18bS5aEwgSEbCg5vwmL28eh1oiWANf4ifjL+vXTdyuy/p2wmX3
	yjTqeXiMGoOZfH1MeRB0N5RMz1mwiJWd4VrH4g4fZMWgN4+Yv2E6TxNs0LByRWSMW3GeelSyTgHm6
	jBO34TRv1Gn0PVslqWceggHMByTT8r1RYZM9tJ18RmTmuA2t2VmCMz26j7ZchsTb3jw14XeXblhbO
	6XPt6HID9YIHwXm4e/lGIVabBTg6yfoj6hF7B8CygRf1r7TdixUh8EkeTRVEQcuwp71z74cOU2FD7
	oKNeOHIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKSE-00000008DY4-2pLA;
	Tue, 03 Dec 2024 04:24:06 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKSC-00000008DXB-0wzg
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:24:05 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so2199788a91.1
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199843; x=1733804643; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXQSNMgJqzof335xyb+wQpRamNOgF+00bnDFWmwyFUg=;
        b=dX/d5SWuYLvC87/fr00A7wlDE/hHbrlo24A7dlx0XnrYHbZicCjpNig4qHP6KZuWzo
         GLSk1dEHhpHqaNS9qHuScvr/0UQwJ86jAjstE/o0hy/oFDrpRCnNoCuRETIj4+/UcD9r
         nhTmDbAO2sEHoQPlhg9h1c6G4ia6vejVoQOY2atMjsdkrIYBG9I2PhLB0a8UWYnEjrxB
         DHt4Ug+SvOyHqLf7TxT+Tjg6l++C+pORbsN4ZiiXa47oPvYFZjNkxfumdRFKoTMzcqsD
         UTSgr0EX3aOF8rlUgJb0V+QdMq1Q6qKekYMaEiwPBVFB76I77TFICRM+ONC8LSlS6imb
         TkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199843; x=1733804643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXQSNMgJqzof335xyb+wQpRamNOgF+00bnDFWmwyFUg=;
        b=Q+poNLnLe3ToNrE5a6cdj1v0yr1QL1zMiqphgVg5bs2UxxTH4+TDy3zBqF3/uKbZoF
         WGngEOo9ecg7aerNRmGV3lgWQ1Hsn2Mtes1aT+Eg2r6uzRKr5gvwIjv7G0w9Ne/24Bd1
         XJMCejVTEW8mFbXnhvLEgqcm7s7hFQrD2x552tIbGlV70DybEjPRdFGUy08kV9rh9xeK
         NIX9VNsD98kw/xMijMO4a/oML92nHXACvfkezUOhIQnNQPQ0K0jiPv5HNUy3Er0SmyKu
         XKaNRB5+Ylfp05BhWOykc4KPRyD4CZoSM2mP4E6ufNZlkF+fzQ7TpE0/RHFkn41SrMHN
         6YUA==
X-Gm-Message-State: AOJu0Yw4/pRv2/7C8t9SfJLsrwtm3vmp+oBsbcbatXiznI4IHenuuS5J
	YBOdmFWOjYBnlEm4mKQfBUTfDnwgs7g06o1mNg8kG7fQH2q+UDRa
X-Gm-Gg: ASbGnctPn1aGHr/wh94nOafBmyLtSeEdztKT1UB7lf0E6PfWDqNrkB691h4DDtO2a4b
	rNgdRwei9eULuq6MWAOWbi6xlbVsUF3xby1B1EYRozLCH/goApleDSirpNUBbTz4leWvS+/uXqx
	cdUlfqDUZgeTg68W7YNIofaE60MZfVvBxYTmmwtOyPj2zYMzE4ILN/oMXmFtIQMKBkgtvSxm5W2
	TdhelC0+S+upQSQY/h7DF2gmxfctiNTbiry33I7r4i9nDb1dCbBMfCnOWkMr2zNhP87GErRkvf7
	OTmv3m9r/B1DhMlThO42
X-Google-Smtp-Source: AGHT+IFsncuMk1iZvIOADAuVRku8+jm+emK4DVpGD3BPQhW+sGjVqukI772XeJMxHHxVJZkvcmbk4A==
X-Received: by 2002:a17:90b:3c09:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2ef0120cd6amr1747611a91.20.1733199843057;
        Mon, 02 Dec 2024 20:24:03 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eead160674sm4074719a91.3.2024.12.02.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:24:02 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 95A42DD3A0F; Tue,  3 Dec 2024 13:24:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 12/13] um: nommu: add documentation of nommu UML
Date: Tue,  3 Dec 2024 13:23:11 +0900
Message-ID: <cd3fe97ca4520f3d24126bb0353ee557a19e5253.1733199770.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202404_269319_77D58CFC 
X-CRM114-Status: GOOD (  28.47  )
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
 Documentation/virt/uml/nommu-uml.rst | 230 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..3194b6ff8877
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,230 @@
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
+- boot kernel, install seccomp filter if ``syscall`` instructions are
+  called from userspace memory based on the address of instruction
+  pointer
+- (userspace starts)
+- calls ``vfork``/``execve`` syscalls
+- ``SIGSYS`` signal raised, handler calls syscall entry point ``__kernel_vsyscall``
+- call handler function in ``sys_call_table[]`` and follow how UML syscall
+  works.
+- return to userspace
+
+When users enable the zpoline syscall hook (configured with boot
+parameter ``zpoline=1``), the code path looks like below;
+
+- boot kernel, setup zpoline trampoline code (detailed later) at address 0x0
+- (userspace starts)
+- calls ``vfork``/``execve`` syscalls
+- during execve, more specifically during ``load_elf_fdpic_binary()``
+  function, kernel translates ``syscall``/``sysenter`` instructions with ``call
+  *%rax``, which usually point to address 0 to ``NR_syscalls`` (around
+  512), where trampoline code was installed during startup.
+- when syscalls are issued by userspace, it jumps to ``*%rax``, slides
+  until ``nop`` instructions end, and jump to hooked function,
+  ``__kernel_vsyscall``, which is an entrypoint for syscall under nommu
+  UML environment.
+- call handler function in ``sys_call_table[]`` and follow how UML syscall
+  works.
+- return to userspace
+
+With zpoline syscall hook, the latency is greatly improved while
+startup time of a process cost a bit.  See more detail in the
+Benchmark section.
+
+What are the differences from MMU-full UML ?
+============================================
+
+The current nommu implementation adds 3 different functions which
+MMU-full UML doesn't have:
+
+- kernel address space can directly be accessible from userspace
+  - so, ``uaccess()`` always returns 1
+  - generic implementation of memcpy/strcpy/futex is also used
+- alternate syscall entrypoint without ptrace
+- alternate syscall hook
+  - hook syscall by seccomp filter (when zpoline isn't used)
+  - translation of ``syscall``/``sysenter`` instructions to a trampoline
+    code and syscall hooks (when zpoline is used)
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
+::
+
+   make ARCH=um x86_64_nommu_defconfig
+   make ARCH=um
+
+will build UML with ``CONFIG_MMU=n`` applied.
+
+Kunit tests can run with the following command::
+
+   ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n
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
+prepare the filesystem for the quick start::
+
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
+
+This will create a file image, ``alpine.ext4``, which contains busybox
+and musl with nommu build on the Alpine Linux root filesystem.  The
+file can be specified to the argument ``ubd0=`` to the UML command line::
+
+  ./vmlinux ubd0=./alpine.ext4 rw mem=1024m loglevel=8 init=/sbin/init
+
+We plan to upstream apk packages for busybox and musl so that we can
+follow the proper procedure to set up the root filesystem.
+
+
+Quick start with docker
+=======================
+
+There is a docker image that you can quickly start with a simple step::
+
+  docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:3.20.3-um-nommu
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
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-nommu(s),um-nommu(z)
+
+  select-10    ,0.5544,29.7143,2.8920,0.2834
+  select-100   ,2.3992,27.7262,3.7794,1.1732
+  select-1000  ,20.4708,42.0885,12.6920,10.0434
+  syscall      ,0.1734,26.2471,2.6070,0.0999
+  read         ,0.3433,29.8828,2.6923,0.1327
+  write        ,0.2866,25.9753,2.6925,0.1325
+  stat         ,1.9195,40.1164,3.1813,0.4642
+  open/close   ,3.8657,63.4730,6.2049,0.7283
+  fork+sh      ,1161.1111,5216.5000,462.3077,18744.0000
+  fork+execve  ,536.5263,2117.0000,131.0633,4840.6667
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-nommu(s),um-nommu(z)
+
+  getpid,  172 , 26807 , 2614, 104
+
+
+(um-nommu(z) is nommu with zpoline syscall hook, um-nommu(s) is with
+seccomp syscall hook, respectively)
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
+access to mmap_min_addr (if zpoline enabled)
+--------------------------------------------
+As the mechanism of syscall translations relies on an ability to
+write/read memory address zero (0x0), we need to configure host kernel
+with the following command::
+
+% sh -c "echo 0 > /proc/sys/vm/mmap_min_addr"
+
+supported architecture
+----------------------
+The current implementation of nommu UML only works on x86_64 SUBARCH.
+We have not tested with 32-bit environment.
+
+target of syscall translation (if zpoline enabled)
+--------------------------------------------------
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
+ - https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf
+
+- zpoline: syscall translation mechanism
+ - https://www.usenix.org/conference/atc23/presentation/yasukata
diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..aaffff989580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24186,6 +24186,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


