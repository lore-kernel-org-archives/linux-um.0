Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E66410F6FBF
	for <linux-um@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uhchMG1KpDGCTR20nQi2G4K7t9Zb0mD2F3Im1tSDrIg=; b=IabvWWUJSX5JQwDiVjQmxiSPDy
	qP0O7vqVmqmW8B7NiEE1jq3FBcGqHcjM/WkUNs+bP8W3n66sgmYeaZMGhA/66Plau5lPKw6/+vING
	UkA0WDkCvsyJWoL6sGq0kIx+IfT3zLrc3ULqVlCh98ABnRDiwlBYKz/P5nvE+xKwtHHAiRhjR7Luf
	7MsUSNiLPIgsjA1qjuPLzeIj/U9ZRhjXcPlbiGm/dSiwEshQ5TuKys6zlAatS82X2tBzyNX0awR4q
	MgCxOybmnM+wfBcNI16gUyA+E+aGtade60VbaSqzpb5/RyUzW2vomcHDr1s7U4nJECDXT+ur6iCm+
	EocONnhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7y2R-0000000FgnS-2dqw;
	Wed, 01 Apr 2026 16:03:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7y2P-0000000Fgn1-3l4R
	for linux-um@bombadil.infradead.org;
	Wed, 01 Apr 2026 16:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uhchMG1KpDGCTR20nQi2G4K7t9Zb0mD2F3Im1tSDrIg=; b=XtJD4s761Lq4UWtfDC/ryTdVHJ
	I5o9HsRbl4T9u4EhDVgdUmhXW1AGWrke2B3BWLTgj0GfmXRwU5ELkPj4HKKD7b5ny8++4GQEM+n+e
	SiHHXSU3wVn8rwT3cMl1py4MhImjmFmowGXlsyJFC9k/pj9/nMybeZuX43hOwW09nkHQhRtSJEo2I
	TaMCsxPjHWpmTVp80GGkvWrsTWP8iznEzjqsGDAPd/4Xu5TjrS5mDH9x76DdmhQufiVq6TW1EWG1G
	msNnU4JnFznsBSkh7QDG6ObnwuN9FqubiD01HPfnZ9MOAzAsXuoLAIriQdk0K2hBo+RH0buuiKeBk
	RuJy+ULQ==;
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7y2M-00000000qJW-0olx
	for linux-um@lists.infradead.org;
	Wed, 01 Apr 2026 16:03:24 +0000
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowABnC2fDQc1pzBThCw--.49325S2;
	Thu, 02 Apr 2026 00:03:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] um: reject out-of-range port channel numbers
Date: Thu,  2 Apr 2026 00:03:15 +0800
Message-ID: <20260401160315.88534-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnC2fDQc1pzBThCw--.49325S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4DGF17ZF1xGw13ZF1fJFb_yoW8WrW3pF
	WYy342krZ3Ja1ay34UWa1Uu34Yq3W2yay29FykJ3sIvF1YvFyrWF4Ygwn0vFnrGFWxJFy0
	vrsYva4IvF1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v38UUU
	UU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_170322_775647_936B9E6B 
X-CRM114-Status: UNSURE (   8.83  )
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

port_init() parses the port channel number into an int, formats it into
a small fixed string buffer, and later passes it to htons() for bind().
Out-of-range values can therefore overflow the local device-name buffer
and still get silently truncated at the socket layer.

Reject port numbers that do not fit in the 16-bit TCP/UDP port range.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/drivers/port_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 3c62ae81df62..b3d393811d69 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -19,7 +19,7 @@ struct port_chan {
 	int raw;
 	struct termios tt;
 	void *kernel_data;
-	char dev[sizeof("32768\0")];
+	char dev[sizeof("65535")];
 };
 
 static void *port_init(char *str, int device, const struct chan_opts *opts)
@@ -27,6 +27,7 @@ static void *port_init(char *str, int device, const struct chan_opts *opts)
 	struct port_chan *data;
 	void *kern_data;
 	char *end;
+	unsigned long parsed_port;
 	int port;
 
 	if (*str != ':') {
@@ -35,12 +36,13 @@ static void *port_init(char *str, int device, const struct chan_opts *opts)
 		return NULL;
 	}
 	str++;
-	port = strtoul(str, &end, 0);
-	if ((*end != '\0') || (end == str)) {
+	parsed_port = strtoul(str, &end, 0);
+	if ((*end != '\0') || end == str || parsed_port > 65535) {
 		printk(UM_KERN_ERR "port_init : couldn't parse port '%s'\n",
 		       str);
 		return NULL;
 	}
+	port = parsed_port;
 
 	kern_data = port_data(port);
 	if (kern_data == NULL)
-- 
2.50.1 (Apple Git-155)


