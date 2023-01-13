Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B92C678D6
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4BKDSwLnuDlEM0QdUL4x6bj0QS9hISLNF5BHiHQoh8=; b=KUqHgZ91udH5vw
	8uXSYojZcqkkwYXUxybSEnWWzYsgufwJA7MroMyZRYv1RQTBX5jG39iZUEgRJpY0RWgq5znUbVyq0
	YHuTBCI2ZPgE1WbBaSreY4FeHDl+TRybYyjDgTfC+TE4MctsyTZHscJT8qxdV315WlW1TxlYdgbIC
	h//XfZ3wt+2G+9WMcHy+6K/0TVSXk6ZLWTOuFKdCoO3T3gpxaF4/CWWbO80VBJBcTUtX90IJr0t1z
	gZTJBPXcbR7kwvQCRIvG6dZqg77E90Vk1pM4H4/mjmZML5cW+Rs9maR360qAfNM2eB4H53oOYM5Un
	oE/8kUUFmjhw4VkF3Bag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0I-000RN8-KO; Fri, 13 Jan 2023 04:49:22 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0E-000RLD-3s
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 04:49:19 +0000
Received: by mail-qt1-x82f.google.com with SMTP id g9so3641843qtu.2
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVbqtFvEqcEY6PTmCOfzPzIYvqXqj8MQaEjPBYbJAVg=;
        b=oSg0uTIKfexVL+8ythAlt7gKQD/HGKHc+xpRHILJIbXc/Q6TtTwAm9x3UWR9dlzThP
         PjoCNQjMofO/IuVqMEF74cp1PkNogOp+PcpAFL2pivlh//Mz+FnEt/Zc80N/JXgNln/A
         8mcDcquFzM7ANPNCVQiN/Bsv6C2yDAJnlJf6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVbqtFvEqcEY6PTmCOfzPzIYvqXqj8MQaEjPBYbJAVg=;
        b=f/g06w9hXiibh6LX34G6DJUzoCZyKPEs8whEWzST4y7+K9XB50E5RJ1nIwm4ne3b3Z
         Awaicb/5vDLAxHO1JBxjORh7YywteyLhGnxiLPt+rsZScda9QHD7rGpEJdIO8TaW/Wea
         Plf/2PODE8yW6JL/zz8Hh+/0lg4w1P7Wqn5OTi5RBUO7c4bAWLyAE7Pk0ijl1UOrYZVt
         Tiu3VPVDQ/e+jm9OGzGaU15eYQoCgjX18E7kvp3ueLCfz+MgIdPAUdN7jDPQPED6FAwM
         xsjQlCY9hlPfpQKuXe0U7abZnH+2mqYdG6CDnilZcjII+RqPbdsjOeuiiPUe0j9BhBaK
         Ijhg==
X-Gm-Message-State: AFqh2kpAU14kpOnjDytRQJkO75dPHQd3pUeHc3vexWnzv9wytY0/A6JK
	rG7ruDNkAuUG4m2gzSIGHExpaA==
X-Google-Smtp-Source: AMrXdXs+4Q/0riaBJeBu43Ip9QqbHlVe2IR4rPwv7GEQW2g23YhJETxm7QMFvfo07vTpZzy0lcWyfA==
X-Received: by 2002:a05:622a:1750:b0:3ad:d7a6:76d8 with SMTP id l16-20020a05622a175000b003add7a676d8mr30209523qtk.38.1673585355266;
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 12 Jan 2023 23:49:07 -0500
Subject: [PATCH 1/4] um: Make the definition of cpu_data more compatible
MIME-Version: 1.0
Message-Id: <20230112-um-v1-1-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1683;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=aGrL0ysPMYznOqdL0cA76sdMuDBI2JGj/mTkJStMEDk=;
 b=N2azVPGy0zYLU0iU3/UHyqtpzJsGGCVO2bIRlbOLxNGtGUyvZZ/Jdj31qhwLcIqfA33a965MpYY5
 tv/1TV+mARDuKlsafc554to1VTS6vsw1ltMTV8PZOe4nzSx4GHum
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_204918_198580_E6E83E20 
X-CRM114-Status: GOOD (  10.53  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

TWF0Y2ggdGhlIHg4NiBpbXBsZW1lbnRhdGlvbiB0byBpbXByb3ZlIGJ1aWxkIGVycm9ycy4KTm90
aWNlZCB3aGVuIGJ1aWxkaW5nIGFsbHllc2NvbmZpZy4KCmUuZy4KLi4vYXJjaC91bS9pbmNsdWRl
L2FzbS9wcm9jZXNzb3ItZ2VuZXJpYy5oOjk0OjE5OiBlcnJvcjogY2FsbGVkIG9iamVjdCBpcyBu
b3QgYSBmdW5jdGlvbiBvciBmdW5jdGlvbiBwb2ludGVyCiAgIDk0IHwgI2RlZmluZSBjcHVfZGF0
YSAoJmJvb3RfY3B1X2RhdGEpCiAgICAgIHwgICAgICAgICAgICAgICAgICB+Xn5+fn5+fn5+fn5+
fn5+Ci4uL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
YzoyMTU3OjE2OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYY3B1X2RhdGHigJkKIDIx
NTcgfCAgICAgICAgIHJldHVybiBjcHVfZGF0YShmaXJzdF9jcHVfb2ZfbnVtYV9ub2RlKS5hcGlj
aWQ7CgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBGb2xleSA8cGVmb2xleTJAcGVmb2xleS5jb20+Ci0t
LQogYXJjaC91bS9pbmNsdWRlL2FzbS9wcm9jZXNzb3ItZ2VuZXJpYy5oIHwgMiArLQogYXJjaC91
bS9rZXJuZWwvdW1fYXJjaC5jICAgICAgICAgICAgICAgIHwgMiArLQogMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC91bS9p
bmNsdWRlL2FzbS9wcm9jZXNzb3ItZ2VuZXJpYy5oIGIvYXJjaC91bS9pbmNsdWRlL2FzbS9wcm9j
ZXNzb3ItZ2VuZXJpYy5oCmluZGV4IGJiNWYwNjQ4MGRhOS4uNzQxNDE1NGI4ZTlhIDEwMDY0NAot
LS0gYS9hcmNoL3VtL2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci1nZW5lcmljLmgKKysrIGIvYXJjaC91
bS9pbmNsdWRlL2FzbS9wcm9jZXNzb3ItZ2VuZXJpYy5oCkBAIC05MSw3ICs5MSw3IEBAIHN0cnVj
dCBjcHVpbmZvX3VtIHsKIAogZXh0ZXJuIHN0cnVjdCBjcHVpbmZvX3VtIGJvb3RfY3B1X2RhdGE7
CiAKLSNkZWZpbmUgY3B1X2RhdGEgKCZib290X2NwdV9kYXRhKQorI2RlZmluZSBjcHVfZGF0YShj
cHUpICAgIGJvb3RfY3B1X2RhdGEKICNkZWZpbmUgY3VycmVudF9jcHVfZGF0YSBib290X2NwdV9k
YXRhCiAjZGVmaW5lIGNhY2hlX2xpbmVfc2l6ZSgpCShib290X2NwdV9kYXRhLmNhY2hlX2FsaWdu
bWVudCkKIApkaWZmIC0tZ2l0IGEvYXJjaC91bS9rZXJuZWwvdW1fYXJjaC5jIGIvYXJjaC91bS9r
ZXJuZWwvdW1fYXJjaC5jCmluZGV4IDc4NmI0NGRjMjBjOS4uOGRjZGE2MTdiOGJmIDEwMDY0NAot
LS0gYS9hcmNoL3VtL2tlcm5lbC91bV9hcmNoLmMKKysrIGIvYXJjaC91bS9rZXJuZWwvdW1fYXJj
aC5jCkBAIC05Niw3ICs5Niw3IEBAIHN0YXRpYyBpbnQgc2hvd19jcHVpbmZvKHN0cnVjdCBzZXFf
ZmlsZSAqbSwgdm9pZCAqdikKIAogc3RhdGljIHZvaWQgKmNfc3RhcnQoc3RydWN0IHNlcV9maWxl
ICptLCBsb2ZmX3QgKnBvcykKIHsKLQlyZXR1cm4gKnBvcyA8IG5yX2NwdV9pZHMgPyBjcHVfZGF0
YSArICpwb3MgOiBOVUxMOworCXJldHVybiAqcG9zIDwgbnJfY3B1X2lkcyA/ICZib290X2NwdV9k
YXRhICsgKnBvcyA6IE5VTEw7CiB9CiAKIHN0YXRpYyB2b2lkICpjX25leHQoc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICp2LCBsb2ZmX3QgKnBvcykKCi0tIAoyLjM5LjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K
