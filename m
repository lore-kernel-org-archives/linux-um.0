Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C586C77B7F
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=; b=vHNXe6NkF4hTdqJ1rJ/msPN+U6
	+Nsb5UFIOVYkY8IHB8U7G575wU1T1RJsy+TwwpjE7pvP2i5m4B58YHMY8f4/xAI1SU69oAaKa3DeR
	ffde/NCQ2QHO2xr4oMye9LwLBpQ894QHKTxuoLwUAesQPuDJFExiHqZeYIo0NhrJx+baFSB7A4FBA
	TdBLkB7JImb+zhSHMPFnKCah4om4Ar7Yxp0fXUFQzgTX5RyQSSZIogQd/ZeI/mSJ29k3sMNyoLm3Z
	YDBJlbl4I1WFX1OAA3emzNd9CRElgwR87If8ua/xE+FID3co9LQ/YclAcIpfbFjj9F3JUn3KjCqH1
	qhpJJtVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKL-00000001FAQ-0HP2;
	Sun, 22 Jun 2025 21:34:13 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJt-00000001Eym-0JA0
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:46 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-236192f8770so23921595ad.0
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628024; x=1751232824; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=;
        b=aVLK2YEDXje68DJi8kKUo9sVRjCSp2diLP+38eaDxRcqKlMJS/DwwsQuIy0wh8dZAC
         8Tf5fqOqWlLWIcPuJSniogMyDF1egZ0uRHUcxF/narif4BiGmzcW2xztmIzN4Tw1eL2C
         P7qGHMsJhTQvoOgDScqXQvwSyt00jt23PEzk/ClI8SX/hKDv+oO/CTxeTWG+zsmL+K4b
         +yXEARcyno9NcUmROlc/xLk3v+TCRBkX9dbgmfNJpzJOblFMCHhH6O4CRZoFhbL+eZ6O
         3ZpRifsKpQqdEQiwPBq38QOCYlrfDYF7I2o74xrhsqU0pyev6barAdOjA5FmaNCO6Iyb
         5Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628024; x=1751232824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4TaMBScWlO5o6sQQ8rBV8o4/7whbCNqAJF2fPQ5Lds=;
        b=K0gOnWBe0nzWUpwSqRg2WLsD7a40uwI05K6UVuB4lA5PY41UkbW+6iSKb6K/0vrXL2
         f9DNqvGx5nf2H6e4jC39m0MqqaNY32Lv7dTifyjOq75cz8NgqA8hLgNu3yMI0/MBlICm
         56Ci8rY38PD5bcdMDjw2lyjvxiuaidWSetSttH8Ciqo8aEMMJkEYGgz5XYnqc7fgPPkO
         MCqWYM2DqwqXLH7o5cI/DR5D0iQJ6qy2oJxcc8FX6i/aKpUOdfGi5/OG1ITNZmPNVecY
         JgAzKotzrr/WqUCYrT8Gmi8cf36R8Cmuwnt4qfo3fq6Q7AxxIUetBh7dJIJuZ913N97i
         P7Qw==
X-Gm-Message-State: AOJu0Yzpv4qfkwbmXEQb6LDNRh9uO71fqTWCrnqpasOeH2NI7L/btSgE
	xRIU53kr7j22YA6SPF3eZm42x6Boz+jru+dgMCuliMrFRdpPe0Yrdgos
X-Gm-Gg: ASbGncurdN2zub7GgR6MM9PYIJeCusSToIL4ElJiFDpx+H3jhHzWxmIRTUuMzt9gFF0
	sZ5jx7Nyp30Fr6Z1duj29QDJvOYFrDGyVAOFa8FJF2Cp6Or01lNJ/lLlUvV2yuCaGLKqQemoReW
	1WwdhPVmbl1aQf7eZKTIjcZZYvsE2x1WQR93IwTm+WNXKtWCXL3e2VC3S2aBqeTWQpqxiT1Dzvw
	Xy6uM51pWC9x138pSDd+lFxvvi2Ir6NKZ0BJfzoIu3LtnjQ/yW9UwlblFRRd3IBQCN/juNqeEud
	L6m3hBpkGywys6L4CUbwI8EIy99Jo4Zcy1rMY02lD1szPf+GRFqNcrQ5ZHm5keX1osY+NFMS3mS
	KiJiJ3shV1OSwmE0gCzq6JXSkWvN2QRSK
X-Google-Smtp-Source: AGHT+IFIxUQ0/YD9Herz6BdBG99RUQWTSP01WOOdLGUJBk0F001Qhh8PYbENqSOqfVF9ZR/sOn/VmQ==
X-Received: by 2002:a17:902:edc6:b0:237:e3bc:7691 with SMTP id d9443c01a7336-237e3bc76bbmr88766475ad.13.1750628024337;
        Sun, 22 Jun 2025 14:33:44 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83955a3sm66601295ad.36.2025.06.22.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:43 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C1671EF1EBC; Mon, 23 Jun 2025 06:33:41 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 12/13] um: nommu: add documentation of nommu UML
Date: Mon, 23 Jun 2025 06:33:10 +0900
Message-ID: <8da6d6a802e2bd4573594aedda3d1f827d86517a.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143345_109405_00BACB12 
X-CRM114-Status: GOOD (  22.99  )
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
index 000000000000..1a988253bef8
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
+lmbench and (self-crafted) getpid benchmark (with v6.15-rc0 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  select-10    ,0.5224,28.3882,27.2839,3.0046
+  select-100   ,1.5641,30.3775,28.8091,3.8546
+  select-1000  ,11.6922,38.2021,32.5367,12.2568
+  syscall      ,0.1635,27.8278,24.8049,2.6957
+  read         ,0.3063,29.0073,23.5953,2.8127
+  write        ,0.2531,29.6342,26.3339,2.7932
+  stat         ,1.8827,41.2546,34.6495,3.3199
+  open/close   ,3.2548,67.5806,62.4781,6.4189
+  fork+sh      ,1108.8000,5618.0000,3604.6667,456.0476
+  fork+execve  ,519.1579,2242.8000,1425.7500,138.1316
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  getpid , 162 , 27049 , 24444 , 2696
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
index ac8ccc837bab..822efc04bbe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25753,6 +25753,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


