Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D066BC98332
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGJLJUYX098b2C/p5zUf0et0pH8c8hAZraf8w7dpmdQ=; b=iMLAx92F1P22bsa0AUtQZVCgr8
	vJPEci/nJY2ATY+31J3zv5IRgt2Pk039TgK1dXKb9QkVoHIZonsCsoAr6n6q0/NtXG4/Cn/VzphxL
	lvwK0d2pgwmYRvqA+Jqskwh5ieyFj+cYBYZ0iT5+MNlb5i1gge1ZoICbIWBcSR3A7P537I5cSmFM0
	MRpimkbEImdx7gdNTHidmlQg6Hu6VfEbxxncaPU1LocaoWyDgf507blmspztaW4yvt+z0xgCvyKUn
	kbJOrPjAEo9uuDCs3awj5D1gUQ9mv2nQhhzg4LZXb7aR+e4xGuBiX81gbh3fAmNFxRz/TqcJMy9TZ
	RCvH5nYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGty-0000000En8F-0uNB;
	Sat, 26 Sep 2026 01:08:30 +0000
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtu-0000000En6L-2b8a
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 01:08:28 +0000
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc79223bcfbso673078a12.1
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384906; x=1790989706; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGJLJUYX098b2C/p5zUf0et0pH8c8hAZraf8w7dpmdQ=;
        b=bS/2zNjZVP++Hri8j5y+7hb+7e17BUaVVGI4iz3oYARhDy3WbRYvDm4i2+kC+8QW4G
         G8EdRlWdGCkQiUmXIMJIeJ7Y3tKyez0dVyk4RhlMKACJXsP+EoEJBxmFvXlEc8gaxgbX
         +Z1bGrmY3CNM1xYeI89h8WrI8PuzKU7pcRz5Cpf0FKuCC2AtlSVcJAM7dWDLZ2NsSo/c
         axFHdredfIgw1wV8eq776w6QBr5PvB9HikWklYbBwiwZ2wcXTiFFBWK7guEC35CRjV9s
         ZJXzUFpb4SjsICYIHg7+QGwDhHFii07tWq+NjRFNdnfuGiaNOscgFktbeo5ve3xChevB
         3fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384906; x=1790989706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGJLJUYX098b2C/p5zUf0et0pH8c8hAZraf8w7dpmdQ=;
        b=ZWJv7o9nqN3kwFiPUMMtzgboKpVpe8yIJ5oe9TcG49GNDX02dlbgpkGofJT5p26DuF
         s7NuHc5aO7nXg4mpAvAOIWqAnEOxHkWFp3qN/a4P1bsJTaiNOUnxnpPdg130FZytLsww
         ewP5Te2Jm9pZnoeQev4vezqKcA2cRzXAZV9CgTVWJqzJcOBGx0sJrin3sB1zqe7mWn8d
         dt+nEh3iWe5WY3KLLhOYNoVxacFFe/EpZ1Kc2jM09ly2zUfkL/YzPnCx9znA6Cc6C2lM
         /5W/RaPgJP6aBmPnujclQ3r8qRkYIAlliWCOU9QOX5sbYFXTrkaPi+Q6xK3Vravgtx4a
         dHQg==
X-Forwarded-Encrypted: i=1; AKwUvBwa0/oDQLfBqkawCOqInTa0PhTV6zoJA0KtxsruXf+PUgKPj9ASl6akZQJJMV9nRY9OQitAyl8TNQ==@lists.infradead.org
X-Gm-Message-State: AFuF++msDfA46labzc3f2TobrsuSpc2iZW2KDG5NeZw0s15t9PTR2jNB
	sDrjv5/u59/MphuTM20cJCbVchBGFTM3ZonnktfhHn7Ya441eh7O63fc
X-Gm-Gg: AYBFou1RcRsC8203LY0SHo2M0o4YQ1od3qSKg0sdfLtULnWqr+P28ECmZy7zIf9qMjx
	/WnJY/NawYSusbdDXYFgg7G1kqAU3/PZs0Vt6t3Epq68X9YQAOn08MvLSc0g+MJKvo0jdvAQF0U
	xXqyqSpGT/+8UbYgv8S/rvna0X/yBHCXWEPAwiNZiScZL+cLadlCnes+wWm5KXiuMMqOoZ3C54c
	+SqwusydwuQIiHExurx7hqYKZqJkDlpoQZ2E4nlgYXtyMkGpAqNZ557fz1ifHyOBf8vxELwthiv
	yiA9WhcwvuTujfD7gYC6YE7Ubo9Hb+Q99crfmYo/Y8ZUY5rcD46sx8Q2v7+eoagJiPdKrx94ii/
	UJcrBbO0coCGKahsTdA9lq7XglQ0oxSgRo7A/1vaG1K3IDBwVbSLne+JFDBHKYN9Z3TbwstKGix
	NgcostVTrpY1jP6q5xLl4APe4Xv+KOMUzIlOJWFF0QzJGkRLQgp3NQFELALvIlKnRe6weLG5jcJ
	aURDzyDYwxutZUz1umnapqerOkHn6XVZoS8t3rKubkMh4T3W2AOyRtzTXEyChedK3iKiOd9+8We
	f5MFrGiSRw5FzIEbEORFY5o+BP0VVckAAJH5ZnlSfhmx2KJjvp6nTJsbljh8zw==
X-Received: by 2002:a17:90a:10cf:b0:3a0:b7b4:b649 with SMTP id 98e67ed59e1d1-3a0b7b4ba36mr2433638a91.52.1790384905575;
        Fri, 25 Sep 2026 18:08:25 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5dfsm13169486a91.3.2026.09.25.18.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:08:24 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 99D8516C9C96; Sat, 26 Sep 2026 10:08:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH v3 1/3] selftests: kselftest: avoid cd - in runner
Date: Sat, 26 Sep 2026 10:08:17 +0900
Message-ID: <20260926010819.604346-2-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926010819.604346-1-thehajime@gmail.com>
References: <20260926010819.604346-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_180826_659605_BDFC79F7 
X-CRM114-Status: GOOD (  10.40  )
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

The kselftest runner currently uses `cd -` to restore its working
directory after running a test.

This is not supported by the minimal BusyBox hush shell used by some
NOMMU targets. Store the original directory explicitly and restore it
with a quoted path instead.

This also avoids printing the directory change performed by `cd -` and
handles paths containing whitespace correctly.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-mm@kvack.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/testing/selftests/kselftest/runner.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 311811dc55a0..8fc1018d6fec 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -130,6 +130,7 @@ run_one()
 				return $KSFT_FAIL
 			fi
 		fi
+		OLDDIR=$(pwd)
 		cd `dirname $TEST` > /dev/null
 		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
@@ -147,7 +148,7 @@ run_one()
 		*)
 			ktap_test_fail "$TEST_HDR_MSG # exit=$rc";;
 		esac
-		cd - >/dev/null
+		cd "$OLDDIR" >/dev/null
 	fi
 
 	return $rc
-- 
2.43.0


