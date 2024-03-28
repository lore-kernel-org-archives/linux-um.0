Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF75AC54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CqmHBgGuhDFAhbRLiaVScv62RrdX1L+enWVRXV7cUk=; b=uScs3VNOnlK7UL4oYfaZi3OSml
	93NHgleOJzbDgEw63+Nyd0OtPo/HkrlYf5xaIACGQ2jsnbDvbbFEAJl9uBDiQR6Qqs89gmZJZ/Swh
	xApqr7F3CiDLFfFSbVHGmAKLbJxusESXaqFUe+9NhiIN//Je3r+/wC4dxKmNoHNPILNDIcjimMGtg
	Je/Cj3dB/lFvjqnfB/sEXuRvVm7hBnKH6b/voms6mZ1GFxhvvjVJpOIG4ccSOwRUeBLDLUdd8LZqi
	4oPmtwzdPhWummyyE48tVQY1CcZLxeaYwIYCWca9plrxE/cmTQF7WjbioJv8CzDONtgPPOk5YJ/Uh
	Rg4pqU6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnY-0000000DFXQ-1Bxa;
	Thu, 28 Mar 2024 09:11:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnT-0000000DFUa-08mv
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4CqmHBgGuhDFAhbRLiaVScv62RrdX1L+enWVRXV7cUk=;
	t=1711617102; x=1712826702; b=juKxyDdBmWr7AwOkl5ioOEuOqXLLmdY1ipmYm12eghEQga1
	4Cdb2v4M8utju1IITVd7BRP9R6rwYjEzermFmYReGJZldFilcpnENAT7KDrjhxkl0WnhJ2NMJAmNK
	6cP3oaLyp59aqGVaTUT2GNlulsas9/+Bdj4am67BHhucuOX2pJIEqV3XCruNcltYXyDwEh8nIhToF
	fnlZaLtq/e2Bqss9czow/VW88Fx7gRE60UPTje4ytNwGesJh3ITGndyxgyzyakcNHeDKpJ8O11gVF
	cZA+CMlnIlTM4zvRsiG72gty3WugEwykwFefB2MO8aGtwF3YhPo/dBODDzv3mL2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplnQ-00000000oe8-3Ryz;
	Thu, 28 Mar 2024 10:11:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] um: vector: remove unused len variable/calculation
Date: Thu, 28 Mar 2024 10:06:37 +0100
Message-ID: <20240328100640.da2074437deb.I8dcad89b470978e3856258d7111ddb101037acdc@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
References: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021143_096433_E33D61FE 
X-CRM114-Status: UNSURE (   8.38  )
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

From: Johannes Berg <johannes.berg@intel.com>

The len variable is unused, so not needed, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 63e5f108a6b9..4279793b11b7 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -712,11 +712,9 @@ static struct vector_device *find_device(int n)
 static int vector_parse(char *str, int *index_out, char **str_out,
 			char **error_out)
 {
-	int n, len, err;
+	int n, err;
 	char *start = str;
 
-	len = strlen(str);
-
 	while ((*str != ':') && (strlen(str) > 1))
 		str++;
 	if (*str != ':') {
-- 
2.44.0


