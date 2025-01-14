Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D26C02186
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDqzX7ON2XBSdEmAqpNpIZ0z3bNXntp71eSx2D8ghE0=; b=Rzxejp9xw0azaPrYOXXGpvH205
	7HNaIQvQLy+dULP02+jBSeSS66aDmYrW/Suyuc2IxRZ+r8zpfpsUiqNqiuUYSg3hWN6TP7BJjK6V2
	DevnVMekFDqnELkDZcyjskAGURujj3iWl2v2xpfz87mmNqOewvAXqiISUSm9p3fvkObOfnBFB/hjw
	nCz7SewtPpnY1wGuA6TQ0nCsQgeYyiwG6LXuLKK7thegN0ohoCsuQyKqdl9eHlTfbE+OCAEnCBZBA
	CGupED309+Bor39qrAD2KXpYLBp3NBIQCCVKij3hApqn2XBYHLrK/3f8od5+UhOECYbH/zdMzpsv2
	qn4eFStw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9e-00000008GP8-1Tvv;
	Tue, 14 Jan 2025 11:32:18 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8m-00000008G9N-1XVd
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:25 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso7057703a91.1
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854283; x=1737459083; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDqzX7ON2XBSdEmAqpNpIZ0z3bNXntp71eSx2D8ghE0=;
        b=ALInvASC19LpJxYJjHArj3EkyK6nZvWFXvHCxAwtR9UbhY/gtkPeexHUzn6a2k5NOH
         W5NKVFpNEeLi2sPgqDnqrTSg0sZx5Zr4/uwpcE6eUtfuq08/O5Dd+xj9JBoz8B9Z1VNd
         5xpwXXLmJHwK+0uKZFpN+vijIYobF6KCpIz+5HBHnkDDfAglnJwE2hcg76SxHRjE9mwG
         p4vw1lKmJJhnA9ZXn781+xWWg95M6GhBhTfOsfYhd+BZSeLHDanZnsTdxvAw1+cNwzTh
         CbQ4LzeiMfozS4AB0V7XU4i7ClnUnSiwfit0ig2LBfV4NqGyzlPwKTedezoWpDlS4QDk
         fXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854283; x=1737459083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDqzX7ON2XBSdEmAqpNpIZ0z3bNXntp71eSx2D8ghE0=;
        b=NG6OvsfTicNEC4eQPGYP+I8/g88cUX1V212Onn6pu/iQLSp7Dh0z02JkGAeTBcFDf2
         6q0He9UHxfrCe3QmNr8UOPZZy6vMit4IrWY6hQMyWO4n4zh06BOuRZhy1sEu/m3ALzu0
         v1KqnRmWfA6S4XY06o41UTh+CPtvLjalBKeuCuflFrRP7yWDW/x5KIWK0nsVEYJez6IX
         pb/jUiVgkd8RRGi6RfyKoJgAWUDZd3C8OuUusqwDZ7aJHY9gwPtHAnC/lJdUgeXCRzBi
         f8B3nfCCyJJQet1uxKG/WtiYNsQVX9zmSCr0r4O6lRXQnsrNlkUbdzrQbEYGr6miDXQ5
         w1lw==
X-Gm-Message-State: AOJu0Yz9583gMJSJS+CR6MkjyzseV6idVun79Qbe2714Fj/Nt/aKC/+0
	GfAcjJJKu6GMO8cdoJuHBGfeX8hm46/klzx1lEveQJYVaQffiVkV
X-Gm-Gg: ASbGncuTim+Imi67Qhfys//hUSew9iH/vPR8aE40Z7XKoio9TBwkLsVdUFbCk3RSwia
	NAj33eMn6OPQbX7i1k6WM9sSq9Ee+kM8W/DvUk8F9yKvIwNRYT8EJgmugns1fIZ6UHInkVi+2Cu
	XZN2FYdKYGMsvKTOnokTV+bM4ZxhODTkkwXJ8o0sqrtag+Y0k8NEWav1DeCcYcaqVkZomw6Ya44
	80gShR0oIqaG0Xprl29oKi53F4kyW38HBJ1xIpRZJWFc46PW01NhZnK8WBODMV3TYHg9qNgfXap
	8uCOyDZCY1Mpr5MySDBeRS9dWfAq
X-Google-Smtp-Source: AGHT+IF+ODA5ZVCSnAugvmfm7JhzCaUMDN3adN67w98z1G2xKi2iVszVQX+GJd5yx0LZILRneaDYng==
X-Received: by 2002:a17:90b:2b87:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f5490ed997mr31403784a91.34.1736854283245;
        Tue, 14 Jan 2025 03:31:23 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d0aaesm10253451a91.4.2025.01.14.03.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:22 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C21BCE1AB64; Tue, 14 Jan 2025 20:31:20 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 12/13] um: nommu: add documentation of nommu UML
Date: Tue, 14 Jan 2025 20:30:50 +0900
Message-ID: <854be12ff829c2e745f8cf03452aa554210fc1cb.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033124_408505_789C4151 
X-CRM114-Status: GOOD (  23.43  )
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
index 000000000000..a98bfd9d2f38
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
+lmbench and (self-crafted) getpid benchmark (with v6.12-rc2 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-nommu(s)
+
+  select-10    ,0.5544,29.7143,2.8920
+  select-100   ,2.3992,27.7262,3.7794
+  select-1000  ,20.4708,42.0885,12.6920
+  syscall      ,0.1734,26.2471,2.6070
+  read         ,0.3433,29.8828,2.6923
+  write        ,0.2866,25.9753,2.6925
+  stat         ,1.9195,40.1164,3.1813
+  open/close   ,3.8657,63.4730,6.2049
+  fork+sh      ,1161.1111,5216.5000,462.3077
+  fork+execve  ,536.5263,2117.0000,131.0633
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-nommu(s)
+
+  getpid,  172 , 26807 , 2614
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
index 910305c11e8a..fc5473fd528b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24470,6 +24470,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


