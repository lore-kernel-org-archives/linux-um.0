Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFE7E7718A
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aDylOpNKsa7qXhr2/8i2qY/1ID2+PNuZp3PlDJbuXoY=; b=HO15NU0qlOP5UB5dr9GMUj6UPI
	mF0/ap9OYgVanKluy5ii3s6JwSCSGKLox7NlTTv6d0/N1W/iIFOjrv1B/W2NfjRXyw04SQSWXhWEz
	E54/TZt7ghYsAPxXmiOldUOr2HmYk2QfM2h+GZZDqlHIQ9n7PTFbl8ivTbNLEWPk5D02+E5zc++92
	9BTA4lO0x7723u7W6zxNgNNA3u8CN6xlSnPUhki04ogbRqEq92GfRPKWZ2VGt7v+TgPblUWl0HWNK
	Y0b/oc3fifkApL9MsbsH5XM/My4apoXGMY85iaEnkpXiTIT4gEJDr7h1oQU0+8ROiyJ/Uq/UwL5IH
	DTNGMdNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDh-000000001W9-1pTy;
	Thu, 12 Dec 2024 10:14:57 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDV-000000001Nd-1ANX
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:46 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso339719b3a.0
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998485; x=1734603285; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDylOpNKsa7qXhr2/8i2qY/1ID2+PNuZp3PlDJbuXoY=;
        b=Mfxsz1bkpXL00jQ4VpfGMCXqoK9oVVMld+azI2/mEy56SuLDGfMzPgWE9kPQknd5e8
         db3/dgLlxO6CyF5PkUKQ9/wy/v/X8ZHsMzfg4rudxrRhLJh/iYr4H6AVP61ZZCkNoc6g
         nEytvAwyfwDaLXrTayqr6TmE/6wRoNHogEkHWTwp3AdMTdr7Pu7RQYDJ/9ToAIsOiCoW
         VS95np3HtQQm30byRBftaukp3vREIM7rozbpgD1GO/vIoLc24cfC9/MOyVSgHrvDjhVt
         0fzPG8+mV587xUUBkVlHRcqhsphvXIocB8MLq/ybJAqDEGV7LgmIX70/y161ds4csld/
         MT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998485; x=1734603285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDylOpNKsa7qXhr2/8i2qY/1ID2+PNuZp3PlDJbuXoY=;
        b=mSCW372fFas40gZymsVgpaYpd7l1f4JF5wwtaITCqxxxnal/A824iQINPc6YvtLfSp
         E2hAbr7N3Dgt+hwmc5XSbx7tmEemgj/+YjQcwa+VPLH8cRSe7r8Zz/+k+sWNs+ndkTCo
         0Voot/JliYDJnl3R3j0WIHU7osTYiFCmBSOBkC1ZSYVjDo2027rxxHj+LdZEbo8zCa7a
         Ekqy9kpr1xcCeJEXPkTbNP8VlrgFd8TZiKVI0//p9sov+InhDpYUVKYwDsWlenawnDFL
         LEPwLyCESa4/cZi/C2mI+MLuRiauMYuYQx8QG0+lbZNECIfZXeqGGLWmMEiekTLWJboH
         sdrQ==
X-Gm-Message-State: AOJu0Yx+RTBrBSiHMgrXFJz5/obWs4iwnC688wiHwSvwKX4OVubUprUC
	bctgmpFFC4tG1XARxmYverXwNrOBDHQlmDSSDEt+EnnKOZOQZZejbFUNKg==
X-Gm-Gg: ASbGncva0A8VTENapVOaRLpHw0UchG0w+YOSjCSPC0CjIwTH/Wf32xqxpoi22CF1We0
	DTm3052Os54aqIONK05n+exkqQ0k0ZSgxvL+c3AGH7OvwiXDocmK/UApYSADljxhhE6hEhFmwEm
	BiXjOIIcltJjYb1hLSDETig3+vFhTREWRm5eoVMFf+99gw53uQihUH1pVTX9UmHVgRNKRW3z9uO
	0U2XRMXVxL9dkalRnRYjLJyo+VEIy5nvz/duAJweE3e1A/to0uBFF2+oofhyZWBGfYwEDFezkZq
	OwUZfmITXylV5zDyN078olgvxlM=
X-Google-Smtp-Source: AGHT+IEJWAcbTomznRHa4tVcc8pc1CxGzHMw4sObbPOgfRhMy3BcIjybyB963AmokmKl5SKeE1Y+3Q==
X-Received: by 2002:a05:6a21:9988:b0:1e1:94a2:275c with SMTP id adf61e73a8af0-1e1ceae2ec7mr4084173637.18.1733998484395;
        Thu, 12 Dec 2024 02:14:44 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72739e569e6sm5644796b3a.162.2024.12.12.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:43 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AC592DDEED4; Thu, 12 Dec 2024 19:14:41 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 12/13] um: nommu: add documentation of nommu UML
Date: Thu, 12 Dec 2024 19:12:19 +0900
Message-ID: <ced1b154352ce289b47208b71bd536457af778ea.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021445_315574_6C0D976D 
X-CRM114-Status: GOOD (  22.75  )
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


