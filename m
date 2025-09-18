Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D6CAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=; b=GQR7nWfkBkW8+hyH+AwvZGQnsm
	0i3dWh4N//7vHu6I6Q+mnlzU9LsWURo7go0nfxKYQxEIzCqAr3W1NHopPQiKO/22FK2LiNKRd2Khk
	zjsDLoUQK0Mcg4tiF6x++a9QV0vKtPmZE0KJc7SQyNcTJK+6PT+wsQ2/3XT5Z31qhGALqz3pZDs8H
	3QaRsQJycVdgT4Bih7+S/NqTdQsHirkkK027Je3e7fICWrkfI87n4k+dz2aaW2EQrs2v4Q1+3uth3
	KzvSedVe8UXhqhVGf7dMJ0es5RHM4dgLmMkEBOqVXpoWcKhzlM3TpoJ2x3dmCHzFQjPO46ZKES8b5
	1NVfj3bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70u-0000000GIT0-36LI;
	Thu, 18 Sep 2025 05:17:00 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70p-0000000GINq-3FMc
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:58 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-77b2e3169dcso766657b3a.2
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172615; x=1758777415; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=mWM3i77VMBXFkgpSPS9iKmEiXJWT0AaTx5c9iZ3x/7WYUdR5WHzJ1BvowVNPVnlKr4
         T9AIclHc7BSV36bUekVJ2jrzmyLE4TFNWL46r4anB7Qm4ysbdxQvCpMBGcLhe4GB/TRm
         ksnsJK3Dtp6MMa8hB1hWAAR7mGPhNqUmWWkXmPlhHPWy11QboZByt6XO+D279Ehp0GU0
         6y7EGxm2BYgGam4ioZAoDLVmJk1CMYcQnU/p52Hi23v47y+PTVigeSHg9ekZsSDu3mV6
         r6ocvrFh4RJehqN1WnUVRnKwk3S/5185LXee0lbbr0Z2ziAEaLYmjdmDlcyJi3GwEgmc
         ySJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172615; x=1758777415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=Oy9sJ5IP92hhMl2sGfnOf4HNlN6IfLC4cWx4dQumnReP5/7NR+DIzlN8z2lO9OntL4
         b42h06yL55Dudyew3WzJ2HOn7SpD8TdaTbT3Py9xEg2c1FYhzWmz5oGDNsoGxQ3YXHOC
         gth8V5ZiLyOTyQIs8fKRIOKL5hgJKS6pBKVIcft/HvduOdo9ECKbSchkmZABueBR4TuK
         ZT7I5P0eUloqcUGzWO0yu3AsHBkL3cGYIhAkYKnp2x5sogrJvyoKnZ0qt0+1ajWgr/KO
         FYoU9H9yssr0Vo3/4ULWmennOTsAlJhdGKlBcXz2u55xFOYuZTU+ql8F4r91CjJZWOwl
         AVBA==
X-Gm-Message-State: AOJu0Yzgw5PQr8JCh/a+9jVlxXYycF6b2UbLKexyBiYSX8qSWIQd8tSg
	CZHoqbeDJDBFNbTjzV52mljTJfJYSTLuIkYg8cAF4IBYcXaFcCbok559
X-Gm-Gg: ASbGncvCtzOogY1kNOnLv6RV/STl9r61K79QdyXN2JY1l5Eg06/dnAbB9sUXgGoRJfW
	EU8+U/YZPgnFrEVm16ittSQZEP4yCf/klyrPU7BtD6UOzGB9DY2tSxGsN51zJqvMv+D9RWN8LO7
	9P7FK4oD+AX1CNjh6nR/5E/6zpy81G31Prxto3MV29En7kFoORZ22u/kgG8WtWEabBztWxnoP5F
	XMzEBBG+bgJu6rJx/8TrAOe6tf9oKSJdrgfdgBku/zU2bH11fZtYKWTNpdUzzXZXGjQmZp9Up0c
	2g3kkNzzp7M8GWZcENsF4QcVgAqTs7N937O2bYsxCC41sFNhj/a/4VLhDRZknSFB5RAEEg98XL5
	Mi3gjoi+2ayzL/xM3elJSAaUwoth+LFp/7I+ySyzi8tYsNB+yC1pAnGD880sUtI5Fj79pwNYsMF
	4sq2ItGB0J7a4=
X-Google-Smtp-Source: AGHT+IEE5bhAXGPg0At7G00mXMtBGsn7rVxTHuZFoiN+K+q3D4zlIFK5OGVWVsR6FWUseoB/IlYZgw==
X-Received: by 2002:a05:6a00:189d:b0:776:9d99:e3f1 with SMTP id d2e1a72fcca58-77bf9856e7cmr5252403b3a.26.1758172614565;
        Wed, 17 Sep 2025 22:16:54 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc2490dcsm1109998b3a.36.2025.09.17.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:53 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 378A01061EFB; Thu, 18 Sep 2025 14:16:52 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 13/14] um: nommu: add documentation of nommu UML
Date: Thu, 18 Sep 2025 14:16:06 +0900
Message-ID: <16a6c1233ec249e1bd32ad1aca36b0e1e396e1b0.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221655_857353_52CCE0B8 
X-CRM114-Status: GOOD (  23.54  )
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
 Documentation/virt/uml/nommu-uml.rst | 180 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 181 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..f049bbc697d1
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,180 @@
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
+lmbench and (self-crafted) getpid benchmark (with v6.17-rc5 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  select-10    ,0.5319,36.1214,24.2795,2.9174
+  select-100   ,1.6019,34.6049,28.8865,3.8080
+  select-1000  ,12.2588,43.6838,48.7438,12.7872
+  syscall      ,0.1644,35.0321,53.2119,2.5981
+  read         ,0.3055,31.5509,45.8538,2.7068
+  write        ,0.2512,31.3609,29.2636,2.6948
+  stat         ,1.8894,43.8477,49.6121,3.1908
+  open/close   ,3.2973,77.5123,68.9431,6.2575
+  fork+sh      ,1110.3000,7359.5000,4618.6667,439.4615
+  fork+execve  ,510.8182,2834.0000,2461.1667,139.7848
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  getpid , 161 , 34477 , 26242 , 2599
+
+(um-nommu(s) is with seccomp syscall hook, um-mmu(s) is SECCOMP mode,
+respectively)
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
index cd7ff55b5d32..2bc267220b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26300,6 +26300,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


