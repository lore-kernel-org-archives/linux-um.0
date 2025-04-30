Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F584C3ABB2
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHaVuq4Zwe9gLJutKzuA+VGXPhun5t5NN63IcV8lR68=; b=QUyWthC5Tpf8q+V91UIuOlttpa
	ILP6rdjCz3tg0ZTHkjl7nMyCZ0gmTLOB94PsWRaq4NnvUyMEeGaj8LSscYffzx/sQZeOMBz3QM+P0
	n9R+9IvndoCLlLuAi/3GetVVxXxHB5ZaA30KAEsD+XkchE2y8hP5yV5sthISwscvDwNKzb/iaJqUP
	HD9ZfNbTNX+pkA9igOM163R3GKuOr1lrKhupIsDBzQZnV68WLGpJ7GSZLniVNdIMVB7KG1cYIshDG
	cpFmBNzpVK7Y1ZlgO2MzQPFsuC+0WhiWNOnwaJR12IiHQFnB2udTLqnwskBMzDLoM3Y2+Ja7mv7Mh
	IpJKPtUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4D-0000000Bfit-0eCJ;
	Wed, 30 Apr 2025 04:29:05 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3G-0000000BfUk-1lPg
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:07 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso6865130b3a.0
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987285; x=1746592085; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHaVuq4Zwe9gLJutKzuA+VGXPhun5t5NN63IcV8lR68=;
        b=L4XgA0nVdEGfL4jHVGdbDcaE4TCLjozYNZpYEmSbPl0kjCZVbDrbq26OLwaS3IalMb
         R8kg1bymsPK1ULCHcL1TRBViuKotbxg5oxR6/41+31qiCp7pwgok58hJ1M5ppRxQYpHR
         zrJt9xHU23ewcJwZUyvgDaMLq7AW5iJWDAAnN6la4u20zMu4391jlX3SevuOGLWFKcFE
         ugfHeH1wY+TECQjK1ykedL6UzYLxniusVMpu0gfl2Q80HImte3gjPbXR1qbtLz0bFvPz
         o3IcXiGpM5zHjJf7vD8219hTSpbnsarLKf1U+5nkiIsKdMojyfxDM6DGQK7UI9w6beW6
         cdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987285; x=1746592085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHaVuq4Zwe9gLJutKzuA+VGXPhun5t5NN63IcV8lR68=;
        b=Wf6oYTqSeu/vgK3+Kh7HLzubrvV5Mjre0+9xRL6b297joim3wDzxc/kkOIEkq+uQxl
         ZqzIIB13c37F7ZlxEURFtr/WcCp5RshTWdlyahaoHlUbteEpq2lNTkoPLOIIpzsybvFU
         JGGATM7ZvD7yMZWicv3tq/IGTVzyZQnOA5KXfCr/qcPHtzRL44tDbr6/11NhhORiFiAg
         X50giicMmYnFUK51APh5JcVnYQrdsorGYKK6nHSlXK1aj4eP55boQDMTSlzRJ9Xbrifl
         YW8vbaPgn+bnJFVhymUSrYA3smT6Gt9kjDxGCuOXssZNMGUhllRuh9L5LFcdxaWq2Gj4
         ugJg==
X-Gm-Message-State: AOJu0YyHK42xiWE2g0TkkDTdAC3XGym5wHMH31PT3gPfWYvAR4u6rfwF
	YBGaPYSyINdxkxZeoGlhxXHIop6Fqnww0UFbZlOBGNgvz149a0OR
X-Gm-Gg: ASbGncvMP435gcqwku2NSzHLjevBGqTjYgzkin9JgOn295EW94YwBBlg9BDw9T3TG7N
	YYAR6R6lX10Nx17pTnSR2Y93hpiy0Ob+hg6QlabTjKbi2vN60A1lhjaPo5a2k8Jd1QxVI74nlKU
	Do0z9LgyqRBuHCAfdmzuzZu8PKRQbORyrpNGXPJbY35oStgrJu2Anf/jEMSoFS7iCd6Y/7EV8nQ
	PiIGl7NjIIJ/VkEeLOvPd/zmM7USbQNvqyGY3+zxqD3YFBn1rfWZuk39SbusSdVX90txTj3v0xP
	czavh0bOz0G8+t5qB8ZLQtq4sbIbD9fUkoxz7r7BsEHv/bdowg8ju43pJ8FPEoRoeZ7cyyHNCvG
	T/GeAxTDufbY=
X-Google-Smtp-Source: AGHT+IFcLglsLp35fpVY5aAm/RiBDEo8ho6SSo1+56LkhDY+q9Ov9DaIySaSK81WgYdSZ4+KxLTB2A==
X-Received: by 2002:a05:6a00:22d4:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7403a784350mr1721050b3a.10.1745987285190;
        Tue, 29 Apr 2025 21:28:05 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740399230e6sm648218b3a.68.2025.04.29.21.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:28:04 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 798A2E94828; Wed, 30 Apr 2025 13:28:02 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] um: nommu: add documentation of nommu UML
Date: Wed, 30 Apr 2025 13:27:17 +0900
Message-ID: <254209f7e93f7fcdbc16853cad9f0a0ab34c8032.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212806_459490_F57D1AD0 
X-CRM114-Status: GOOD (  23.93  )
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
 Documentation/virt/uml/nommu-uml.rst | 177 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 178 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..2034ba4d397a
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,177 @@
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
+  - hook syscall by seccomp filter
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
+lmbench and (self-crafted) getpid benchmark (with v6.13-rc5 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-nommu(s)
+
+  select-10    ,0.5569,27.0149,2.9772
+  select-100   ,2.3964,26.9242,3.8947
+  select-1000  ,20.8101,39.6842,12.8161
+  syscall      ,0.1735,25.7706,2.6997
+  read         ,0.3488,25.7922,2.7923
+  write        ,0.2861,26.5560,2.7961
+  stat         ,1.9171,36.2893,3.2678
+  open/close   ,3.8475,62.2847,6.3909
+  fork+sh      ,1159.0000,5230.3333,409.1786
+  fork+execve  ,535.3000,2075.8333,135.4074
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-nommu(s)
+
+  getpid, 172 , 24979 , 2691
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
+supported architecture
+----------------------
+The current implementation of nommu UML only works on x86_64 SUBARCH.
+We have not tested with 32-bit environment.
+
+
+Further readings about NOMMU UML
+================================
+
+- NOMMU UML (original code by Ricardo Koller)
+ - https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..6738c3fc1256 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24743,6 +24743,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


