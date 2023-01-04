Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC26EC4708D
	for <linux-um@archiver.kernel.org>; Wed,  4 Jan 2023 08:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Kxyyxr6eEhLa+UtmX1GDZgXnEjLoI4QQ+MQUW2l9LXI=; b=QzCXvSxFyks70D
	LQLREdIYGcPfJCLQNohnMDojWH4X2Z1DeqUpW7ioAGaWvRA6tZKusV8JazoPe9jmd7ll0FElEh8h0
	XnQaaXasR+ktUhgYBnMfTmYR5/NxvuN5KPkB5Yr1oWbqSs1dk8uaN2mfctVv8BysYuSSPD+VcwFnX
	IbfMzw8yFSwbkHQG9o0tu8CCkaRf0G/I6Qm06DVxr0SumyKOdS1sKq87QrV48O8kn0zQ2FOnHiwdc
	NL9J6ViJJryaFHwW3fdaWQ6C75fvVEtOBM5Gz2EEzqoVIufZjAjcIGEWkjOZFj9gxOjbcD8fYsKQE
	B9pc0/8i5D/H7cxa0UrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCyy3-007ZWq-VY; Wed, 04 Jan 2023 08:17:48 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCyvK-007Yh2-RF
	for linux-um@lists.infradead.org; Wed, 04 Jan 2023 08:15:00 +0000
Received: by mail-pj1-x102a.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so38245798pjj.2
        for <linux-um@lists.infradead.org>; Wed, 04 Jan 2023 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/04hUj4xs2kUGhGVqnYdX4sziWnoObx5V1B9hl5JqQ=;
        b=k8HeThodh9qWBuxngqyacfo4g5+HB73+0h0H85Qmckf/9uMZvGJL9gngLx3ZIff0dM
         r03BcCuQi6K9FFuixjlzx+WJbZxyI3lexAq5fyBABaPPpvke8UYXKmjJGAGvwGYbfAQN
         LUxtzEgxVofHfiChEV/lGguxf/xdMXymcBsx0vB68i6JagguiWdsOuIaKiNXrU04TFY0
         Ot3ozNrBGw1aEqfVZbFHDIXrdZfs5nz3ct+8NhrcF4wgofXPj8meUKZTOY64I6ArPIAm
         mGPQ5fG2sg+YdNrGF0D+CkkKKhrtOP6M4u2J9kiaT882Oo2rRoRitFgRzpCDdY3Jnwf9
         rByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/04hUj4xs2kUGhGVqnYdX4sziWnoObx5V1B9hl5JqQ=;
        b=G6zxG+BdTt4eaWRs0O0HuVhtegCvzSv8MC30FJnH0scnIJBZUf3RpATLrtj37ZDQPQ
         ICA5tJyN2rfKFFHMYFfb00HZKgfMKLyAQFW60Upzhc1amS4eG7+lrvA7MbP4oLdYXDOz
         rT+lXRKGRmQ8cB5iGonP6jak6s4MRsWqpa7jBXg6g6DLcpVoC9fF2G3KFrprHkhAaQHw
         0EoUUuVY4/rr9XcnNR9I66QNQ5i4rNXIf+J3c/9efrIKIbP0/3RsAptAwQDURQUlLh8n
         A2C5UHiH9eD+LxyApANagCvD9cLKnbFSSouEGIBhqkdj5/Rxi/2Uk/XhXRiKZBlWK6DG
         hoNA==
X-Gm-Message-State: AFqh2krNc87cKz4X/rB2GNqu0cJlY52Nn1e6Nq7Sri7xyvC2ICcv/gXq
	yh2WLXDWl6TAWGxuosDpJuI=
X-Google-Smtp-Source: AMrXdXuDFLOCGLvqEhuVA1P7tjZlJqfU64nI5+pYdqKdUcbHTBl2EGtG14HtgdicEweAx+q8+TYc6A==
X-Received: by 2002:a17:903:110d:b0:192:8b0e:98e1 with SMTP id n13-20020a170903110d00b001928b0e98e1mr37809520plh.54.1672820095871;
        Wed, 04 Jan 2023 00:14:55 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g12-20020a1709026b4c00b00186a2dd3ffdsm23420819plt.15.2023.01.04.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:14:55 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Miaoqian Lin <linmq006@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] um: vector: Fix memory leak in vector_config
Date: Wed,  4 Jan 2023 12:14:05 +0400
Message-Id: <20230104081408.4074275-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_001458_923137_701119BD 
X-CRM114-Status: GOOD (  10.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

kstrdup() return newly allocated copy of the string.
Call kfree() to release the memory when uml_parse_vector_ifspec() fails.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- only call kfree() when uml_parse_vector_ifspec() fails.
---
 arch/um/drivers/vector_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index ded7c47d2fbe..131b7cb29576 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -767,6 +767,7 @@ static int vector_config(char *str, char **error_out)
 
 	if (parsed == NULL) {
 		*error_out = "vector_config failed to parse parameters";
+		kfree(params);
 		return -EINVAL;
 	}
 
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
