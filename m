Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BBAD2ED0F
	for <linux-um@archiver.kernel.org>; Tue, 20 Jan 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KD9uxamG/J7OB3nrnQDNMq29ygFBuDE9Rmqa6oDTSvA=; b=n+Avp4X4na1aVUrERQRx4iDpwn
	tmZlTFJuIb7QvLMDSwphG7p40DdZx0Qu5nM20t5c1IKVaJJ0oc39RxOezS6DC8O2V+saS9m6D9UcI
	NEcmKo+9ARdaykLZhUwnx+kugxIYtbeAm+2BcAxMHrrUMAZEfgZAV6dmjhGfAKlsT7NIronnVk7ov
	/xjFmK4krDeyePVa/Saoq7uHQNubSjTDODyfIWY7mNE1JdPC6cJlFGmCNsQuTahppiWPbWMz3BhrO
	cm2CZGp8OZRR+BhOINS/mogjGqjm5MQ3hbQUPo0hJ0ASaFvqYmqazFm8NV+pXGGrc/QUjpI8D3n77
	nIk4LZtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi9wQ-00000003iRa-1aNa;
	Tue, 20 Jan 2026 11:30:34 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi9wN-00000003iQi-0ciW
	for linux-um@lists.infradead.org;
	Tue, 20 Jan 2026 11:30:32 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c6113524690so42035a12.1
        for <linux-um@lists.infradead.org>; Tue, 20 Jan 2026 03:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768908630; x=1769513430; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KD9uxamG/J7OB3nrnQDNMq29ygFBuDE9Rmqa6oDTSvA=;
        b=cVOYOsNN4XUpwlOQCLZqaebO+RLUdobSDQMMbZAjGFroBRt9u+i8eA0q+syCLKHIOw
         XAsVZ3/3zlLF6dlNWChiWgJl5f2pN5hXI9JzuopMyTtQ0CKkFlhFKJhtY5IZwsMB/dQ/
         /brY2mHJj9AG3KbETPXo6crOZ4WX9IeR6Wmb/smBuacq/01pXYm7LB4V4jHvv5ZvyH61
         y5TTNyABSwyj+L37D+7REUeE7fBGtof7SJdCbfRjOJqL4HvRKoB4gDBWoaN0jm51P16N
         KetzPzNCM8YwKGTONjCdd2xdhSYa1Y9hQysOxc9l3ntvb/NwYocPu7WZVEkczF6qvVkU
         LWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908630; x=1769513430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD9uxamG/J7OB3nrnQDNMq29ygFBuDE9Rmqa6oDTSvA=;
        b=wzy08Adf23ztIRJcg/le2P3R2NWW/kksJJHxLJ35Gela4I2AbZC1abTH6lNgmyQgBY
         hrYxg1wksOrAtPvxRHZxd3xZ+SFNy6bhBStiG1cmWgYL8ChJcs9hZ9LOwnPD0Tg864ts
         r3wgDgvMj1hC+4hEKQeuYoeCY0M0lFLcgfDN6pF6q5gAZXoT9GXOGnmuLSJCKkQKlimx
         /tPf3lqrZspS0Llxu8N6uI7HDpZMOO9UN4z971+xOkgRj4G4XQKrTAepATMvTy70LFr9
         jnedCfIkGwSUstLnHkd56o3H6Wd7IV0j7UCnEhwYdHKO6r5C6aw7zx8RIsiiq4dQq75x
         tjlw==
X-Gm-Message-State: AOJu0YxQMWNT2UDn0qPsHq6/l1YKozPwivkV7NzvBZEblGn5dYJoJY+Y
	+pegDM/ZsJZ2ce4e9544cb4i/HKyGefqCU5SRDohUwgZU2uPCqpclPko
X-Gm-Gg: AZuq6aKLp6ei8jVIl8qRhpmjZo2SJUvvWWQxxHIpX+XYUK1Ps/Nee4fdB9kZhQd19XI
	RpqLt5W8mvN7+bpX64aS0pXg/5ohd1Fsg6B8ZABi/Wtsn5AjtOxTLbC9p2nszN/1raPwMbwhLEC
	YYoWnvZzAUlhBE4hFXmcGYPvLOVSRc0rJWstonJXqPrtw1V96fjVQjh90AwEYVnBNJF6+EcXMmA
	hgl2hrEk7VwHIk6eHxvHrkcbVgDS/XgFmZ1IT5680wg0xZoBgKxraILsdQPpInCbu+xoWKT4x/a
	/xy34xCt/NMaYaqXXEd3pcAEL56bMflFFsnY/d1TeECpJbMB9snVgpXop8flHBgm53FQ1GHKUoW
	FxyjPr92ktRR/VXWtUDX6MDXATx4FVvKG13ZXKq14D5yHJWDmVafmeqwSH7g7x0j4bYBSnNEVr/
	WR0bQDz5lK2zalAXKyI8e3C4b56hI0B6m7
X-Received: by 2002:a17:90b:38c9:b0:34c:27ad:71e7 with SMTP id 98e67ed59e1d1-35272fd1f65mr12982144a91.35.1768908629676;
        Tue, 20 Jan 2026 03:30:29 -0800 (PST)
Received: from nwang-tw.host.com ([124.127.58.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d57a56f2sm1045900a91.15.2026.01.20.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:30:29 -0800 (PST)
From: iamhswang@gmail.com
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	tiwei.btw@antgroup.com,
	rppt@kernel.org,
	kevin.brodsky@arm.com,
	snovitoll@gmail.com,
	linux@weissschuh.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com
Subject: [PATCH 1/2] um: add uml_kmalloc_array() helper to avoid potential
Date: Tue, 20 Jan 2026 19:28:54 +0800
Message-ID: <20260120112938.463596-1-iamhswang@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_033031_224644_E987E5C8 
X-CRM114-Status: UNSURE (   8.54  )
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

From: Haisu Wang <iamhswang@gmail.com>

Add uml_kmalloc_array to avoid potential dynamic multiplication
overflow. Since in Documentation/process/deprecated.rst,
the preferred way is avoid the open-coded arithmetic.

Signed-off-by: Haisu Wang <wanghs18@chinatelecom.cn>
---
 arch/um/include/shared/um_malloc.h | 1 +
 arch/um/kernel/mem.c               | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index 815dd03e8707..a55a81131e10 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -9,6 +9,7 @@
 #include <generated/asm-offsets.h>
 
 extern void *uml_kmalloc(int size, int flags);
+extern void *uml_kmalloc_array(int count, int size, int flags);
 extern void kfree(const void *ptr);
 
 extern void *vmalloc_noprof(unsigned long size);
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 39c4a7e21c6f..3bf9e9bef3bf 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -126,6 +126,11 @@ void *uml_kmalloc(int size, int flags)
 	return kmalloc(size, flags);
 }
 
+void *uml_kmalloc_array(int count, int size, int flags)
+{
+	return kmalloc_array(count, size, flags);
+}
+
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY,
-- 
2.52.0


