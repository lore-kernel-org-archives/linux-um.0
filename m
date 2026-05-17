Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B52CD4851
	for <linux-um@archiver.kernel.org>; Sun, 17 May 2026 02:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sV6fhzrbrTX0iqeUo8xmtmUreYy8zZzFHjV3sir7464=; b=tdPv6PtFdS0HbEAHZ401Ruevtv
	DUxHjceNvutrEPug1qzUc8vSUpY1S29j6OZS4ExJwV1lYkkdI0JD1/V+Ze/Kd2zCIA9mu7npoGrUa
	M6LUFTXwm2ESbVeKrVwDGFAlfJ+lcrZTX/0r2N8uFdolulRyu0K6GoPmwyVC4DFUcy6MGJVfgVQ7H
	QxLTh03OSnJAzlZyz0KFQVJCQRb6/eCgETI9wX9j09OfLINWs5L6+lepAFQtbq01gKHuLfqZlOLvJ
	js9bgkxwp6RVfnrcEfX0j3onK7SWku2OnZ7itXSB7DR6cjlWUN8o53hWv+xt5eRm78bfv8azaBJB7
	aqtWzxcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wORCH-0000000BvF8-2aOV;
	Sun, 17 May 2026 02:25:41 +0000
Received: from p-west2-cluster4-host5-snip4-3.eps.apple.com ([57.103.69.154] helo=outbound.mr.icloud.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wORCF-0000000BvEc-1ZOy
	for linux-um@lists.infradead.org;
	Sun, 17 May 2026 02:25:40 +0000
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id 56A1B1800188;
	Sun, 17 May 2026 02:25:32 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEC0AFBlgARnkRUAFYHlZeWhdeTVEPDwNKEAJeBV1yGVoUXBhTRVEfVFhBDgpSEhhcFFxQWB5GElYNXQkZBkBeUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKVwBAC04DWAZcAkILTAZbGV4KSQxVAkBEGFpBCkoFLV4IXh9MHB0OWAYMUE0BQwgKAlEcVg1X
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778984735; x=1781576735; bh=sV6fhzrbrTX0iqeUo8xmtmUreYy8zZzFHjV3sir7464=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=y8MFib1H3rIfbmyeZl8olPAG4p7Ap2aO+aLMT+VrsSn0NHQyZWhjdTAgeVSvdLQbVt5sagfcJLwY9cOObAH3NXQ081TiUYa8f/uyNVza2l+LEU8TVyUoMNznKkOtHZroY4h80hmTgmFcoE107do9MeyTQZMkrxASZ/cbejK2ocMOYKlgTzZgz+CNOuutjN0degzhcrEWLg1OSsBhG4LZdRQosE+Q5qZkMHeqXs76ewyoBu2m/2vPWG8SQhbRXwn8Eu3ZpH8QpjPU2gMkgshOIlh3sucU/NGEro1Oqw0sx+NtLMWB77zK0Ebx65kmblx0c7p9HxVHu5Tf4PvJrsVxhg==
mail-alias-created-date: 1778972301885
Received: from localhost.localdomain (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id 5DF73180009F;
	Sun, 17 May 2026 02:25:29 +0000 (UTC)
From: Sakurai Shun <ssh1326@icloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Sakurai Shun <ssh1326@icloud.com>,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: fix typo in user_mode_linux_howto_v2.rst
Date: Sun, 17 May 2026 11:24:44 +0900
Message-ID: <20260517022456.5895-1-ssh1326@icloud.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GMUF0+NK c=1 sm=1 tr=0 ts=6a09271d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=ZxuoajvSgW0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=A5CT-1V7y8jouT4tXaAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=IxSG75etxsVYPPdR13TJ:22 a=inEeFAWOpojiTzPHIy75:22
X-Proofpoint-GUID: VM9EXsHA23NyGS9J0AjnhSgXfyAOqHVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDAyNSBTYWx0ZWRfX6VY+BRc+F+XG
 nkIp9McyifMfMIUc+y/mNrw6V2JKzjK4FptQtpPrnbyFR29pLrztD0PwYQJCadGjHRCNEWaG7Eh
 8+vYgtBYNESBOZjTJkpFhYKsHRjC8p6h2yOS7i5hIrq4aJC7+JW3yvu2ArTtcmS+L7iWW081mTq
 Q4BcmyFU59D1KlwPPESF5Jb3NU7+kGBZU0jaY0rS3UNVFJn1xRWAjLL1xAKPCTX3rQNT9KVLGdw
 vlljWGThqvonsz8Kwzw17pR8z+4+G9RySCHKFzQuYSuhDyQs9oumKkjizJErOVhuEj/k6Y20k0D
 UlmVV8SBQ0CjGC7BsQDQgNKrYZXuFYz/bkr0LwhX9YgAqb3W7QVFQjp5A8jRYg=
X-Proofpoint-ORIG-GUID: VM9EXsHA23NyGS9J0AjnhSgXfyAOqHVK
X-Apple-Category-Label: MjE0Nzk4NjU5NzY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_192539_429457_888522A1 
X-CRM114-Status: UNSURE (   9.33  )
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

Replace "privilges" with "privileges"

Signed-off-by: Sakurai Shun <ssh1326@icloud.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index c37e8e594..9224bea5e 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -234,7 +234,7 @@ an ioctl to setup the tun interface and/or use raw sockets where needed.
 This can be achieved by granting the user a particular capability instead
 of running UML as root.  In case of vector transport, a user can add the
 capability ``CAP_NET_ADMIN`` or ``CAP_NET_RAW`` to the uml binary.
-Thenceforth, UML can be run with normal user privilges, along with
+Thenceforth, UML can be run with normal user privileges, along with
 full networking.
 
 For example::
-- 
2.54.0


