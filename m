Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9955C3ABCE
	for <linux-um@archiver.kernel.org>; Mon, 16 Sep 2024 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LqAz2DZDSQfpAEuQL5O51eFz4tgSk7iYOPQ8/l20hj0=; b=U5iKuPMaa/ASi9gGy+MhxzJia1
	sHHYgw5bXfGl1mzQhtR7a6UtW9dp1os/3ZxWKFV1TU6JvWQ3PMxrQUzrdPoYTq+s8oR8Dx0MxN+L4
	26AfPatyIpXpvOHBTtWGsEXFqPSy/7b68ttbbPwsGpEGHv7dYeTEnMTv/IEQOZ05muWqBzVhG0lU1
	2+erEChjzMZXh+Lb/6XIhMy7nsW2MxKzrnHaEngb/olRUviGglmccUtErgLUXtZXBOqtKrRg7bbN7
	St+iDWKswjF7IoxQVFKhoWdS9L+sNc7QoKMMKrDADniYMUeOa38kPj8PCH6pnMt87pvDG8rYL+cTk
	oYd/5dEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qP-000000035SF-0ZUv;
	Mon, 16 Sep 2024 05:00:13 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qL-000000035Q1-0sH8
	for linux-um@lists.infradead.org;
	Mon, 16 Sep 2024 05:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462803; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LqAz2DZDSQfpAEuQL5O51eFz4tgSk7iYOPQ8/l20hj0=;
	b=IwELLS4bdxGF5JwTa8tyvx6SgBmazk1x1L+A7SHdAsUVtW56uhQ3GCa895tkUL90aBJfCkmgOb78BFyR6YxSBj+6Q487g+PewS4jRWYO3Z2/+Qz74yU0YcA6percZ7cGnMIUz0G1eZpRh7z33C9SedEQjYADo3jpm4q29whe9CI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLOT_1726462796)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:02 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/4] Minor physmem cleanups/fixes
Date: Mon, 16 Sep 2024 12:59:46 +0800
Message-Id: <20240916045950.508910-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_220009_795122_F374D268 
X-CRM114-Status: UNSURE (   4.49  )
X-CRM114-Notice: Please train this message.
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

Changes in v2:

- Add "um: Fix potential integer overflow during physmem setup";

v1: https://lore.kernel.org/all/20240913142137.248245-1-tiwei.btw@antgroup.com/

Tiwei Bie (4):
  um: Remove the redundant declaration of high_physmem
  um: Fix potential integer overflow during physmem setup
  um: Remove highmem leftovers
  um: Fix the definition for physmem_size

 arch/um/drivers/virtio_uml.c       |  9 --------
 arch/um/include/shared/as-layout.h |  3 ++-
 arch/um/include/shared/mem_user.h  |  5 ++---
 arch/um/kernel/mem.c               |  3 ---
 arch/um/kernel/physmem.c           | 36 +++++++++++-------------------
 arch/um/kernel/um_arch.c           | 19 +++++++---------
 arch/um/os-Linux/main.c            |  5 +----
 7 files changed, 26 insertions(+), 54 deletions(-)

-- 
2.34.1


