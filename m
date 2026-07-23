Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D830C531CD
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A16xF82dywTOESMRyLBX55XEWmM1nfhe+n9+DAWi8RA=; b=lBb5S2hAoYyP6FhcTorsDwEcQ8
	9FS3gsmIrAV+YxiZNFf1lknx9c++oMuf8GJ9dUylVg7A6iHTy2r0JNkR+BH6SMVXkFfge3y19f+0Q
	0+LCv+QzQUzo4yh+wx68vQHCznBvXEpld2zISEnnGkkKtqeSfUQSOLQUz/dqpjcAxY5mpkm5ywjOc
	f3s9yUoOBtYKUu6kNI4n9Qh4OjOaPEJMYgazPsk9E5Q9nXwPc0LOejBq38u3qZ28i08iuOCV6f4AE
	nzOq8zb0tOoMMRcg6yNR3xQHxZs5KGrvqjl/j+5TJOHiiQirM9F08BbRgj9HOaxqb8GEcnPbzMUpB
	VYOn/2dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprI-0000000Ds1q-3bsc;
	Thu, 23 Jul 2026 09:36:52 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprF-0000000DrvH-0baN
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A16xF82dywTOESMRyLBX55XEWmM1nfhe+n9+DAWi8RA=;
	t=1784799409; x=1786009009; b=QAMXYr0NF6O2ZVn/5WLGfVpsl37ufnOTf+vN3+2OPgbNF4o
	xW4rvesdOowUjn4j2KvACIr4Nb0z97hus4DlfiWzryFxKeAF+nrvZq8/Iy7uE4+jSbAca2pII5i6k
	SC3ghiMR/N08OySfI5vwje6UnJm5ZlzVhrZvsOkBtKM78Lwg9zTLuAbAGzl1NBHybXJTvRG/lRdqZ
	QFgn+YJTp0VqF/RhfSev48C52oYHs53gD3BATNvzvlKSdpfGafMWi6ciHR0P7JDIASWi0/VWjXaJh
	6HzJdh7dALLkpf7XMdFPBFF+ph0J4016m1n8Ujiu6PltkQs3VZZutKjfw6ZoXQqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmprB-0000000Aeqq-2vc7;
	Thu, 23 Jul 2026 11:36:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 10/10] Documentation: um: document nommu UML
Date: Thu, 23 Jul 2026 11:35:51 +0200
Message-ID: <20260723113633.19c6669dc151.Ibd7a532eef856a1ea39699a263dfa8a9ded9dc20@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023649_196827_2D629B92 
X-CRM114-Status: GOOD (  16.67  )
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

From: Johannes Berg <johannes.berg@intel.com>

Add a description of nommu UML, a bit about how it works and some
notes on how to use it. Partially based on Hajime's documentation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Documentation/virt/index.rst         |  1 +
 Documentation/virt/uml/nommu-uml.rst | 54 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index c1f0bbc37315..142134ed45c0 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -9,6 +9,7 @@ Virtualization Support
 
    kvm/index
    uml/user_mode_linux_howto_v2
+   uml/nommu-uml
    paravirt_ops
    guest-halt-polling
    ne_overview
diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..105e596ae1cc
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. contents:: :local:
+
+Execution model
+===============
+
+When emulating a system with an MMU, UML gives every ``mm_struct`` its own
+host process with its own host address space, and keeps that address space
+in sync with the kernel's page tables by issuing ``mmap()``/``munmap()``
+into it.
+
+NOMMU has no per-process address spaces: there is a single "physical" address
+space that the kernel and every userspace process share.  UML models this with
+a **userspace runner** - an ordinary uml-userspace stub host process, started
+exactly like an MMU userspace process, but with the whole of "physical" memory
+(the physmem file) mapped into it at the kernel's addresses:
+
+- The runner ``exec()``'s the stub just like the MMU case.  The only extra step
+  is that, once it is up, the kernel maps the entire physmem file into it in one
+  go, at the same addresses the kernel uses.
+- Because NOMMU never remaps, that single mapping is all a runner ever needs:
+  there is no per-mm host process, no TLB sync and no ``mmap()`` of individual
+  page-table entries into a child.  Userspace code and data - placed in memory
+  by the loader - are directly executable and accessible.
+- The runner processes hold no per-task state: the kernel loads a task's state
+  on every entry, so there's just one process per CPU.
+
+Running a task's userspace therefore only means pointing a runner at that
+task's code and letting it run until the next syscall or signal
+
+Building and running
+====================
+
+Configure and build the ARCH=um kernel normally, but deselect CONFIG_MMU.
+
+KUnit tests can be run in NOMMU mode with::
+
+   ./tools/testing/kunit/kunit.py run \
+       --kconfig_add CONFIG_MMU=n --kconfig_add CONFIG_KUNIT_UML_PCI=n
+
+Running a normal userspace requires NOMMU-aware binaries.  There is no stock
+x86_64 NOMMU distribution, but a prebuilt Alpine image with musl-libc and
+busybox built for NOMMU is available and can be turned into a root image::
+
+   cid=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
+   docker export "$cid" > alpine.tar
+   docker rm "$cid"
+   mkdir alpine-root && tar xf alpine.tar -C alpine-root
+   mke2fs -q -F -t ext4 -d alpine-root alpine.ext4 1200M
+
+Then boot it::
+
+   ./linux ubd0=./alpine.ext4 root=/dev/ubda rw mem=1024m init=/sbin/init
-- 
2.53.0


