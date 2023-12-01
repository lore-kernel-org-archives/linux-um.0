Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D231C4167B
	for <linux-um@archiver.kernel.org>; Fri,  1 Dec 2023 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dgWt7tHoEP8ws1G7IXHqqSUv9YkTktOnf0ev3cI/T5I=; b=zdfhDhTzQ7hVql
	iSm1rdbToz0jAMfhZmfa+QiFRG2s0n4zU3+qrwn08nyzlhG+0Nd06R/8rBUjlOKkUzvmtUpOkw3ed
	IPowa0haSJ0kR83IH0Sw4Ec4UciIovfN4+9HpCl0ee/meTa31ptHmXby+j/OIxCByffLwrnAyUSk2
	89RGviTU65ZR9Si3Bi61/zTqbx8b24+FMWVAMW52rJpWnP7Tjc6d2/RS3Ylq8Zv3HrU55KOsLHJ5U
	nogNxcq8RuOT/3k+jBS7KR05X7DXULU0ynkQfrSKtCeBZTAXnlgxNvFXMXkXtlFhZTwObM8/Aqmeu
	czL1VaAdtWVkoY6qh5Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r90en-00DC88-26;
	Fri, 01 Dec 2023 10:22:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r90em-00DC74-08
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 10:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fAPRMgCuD7LRyrAM3c4Hjh0YOMt2p9kLheGGBT4T6NE=; t=1701426117; x=1702635717; 
	b=KK7N0sGZ8tiW3nL/G/Xpc8uUglo0G9JI5NGO68RtUC/2o/K7qaVe2sPEGPTykieK9/0En7gQDrZ
	fvJCo4a053waoZCe0oTjQNghnXCVBnLSjNmwHeykvT8FN/1ef1fHJ7se+LCIIVFWb35qPoH8WLZzw
	cz4sZlh+fI/CrkNCQbXQTuEyns1a4+15aga/o0/fHAfHApg+lsi1n8xoS5iBXNpGX8uAMvpXuwP7l
	+LFgnI6bWE2r3IUk6TUiXBQ4tcLQKRKy1DaP6s7sli6xgn1qBMcdapBoZ++muN6Bwcr2MGPmpXFYQ
	551Ta294WzprDZsBzmy27i+XXbCFPoQBNKyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r90eg-0000000BAoz-2lO2;
	Fri, 01 Dec 2023 11:21:54 +0100
Message-ID: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
Subject: jitterentropy vs. simulation
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: linux-um@lists.infradead.org, linux-crypto@vger.kernel.org
Date: Fri, 01 Dec 2023 11:21:53 +0100
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_022200_079530_21AE8032 
X-CRM114-Status: GOOD (  10.31  )
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

Hi,

In ARCH=um, we have a mode where we simulate clocks completely, and even
simulate that the CPU is infinitely fast. Thus, reading the clock will
return completely predictable values regardless of the work happening.

This is clearly incompatible with jitterentropy, but now jitterentropy
seems to be mandatory on pretty much every system that needs any crypto,
so we can't just seem to turn it off (any more?)

Now given that the (simulated) clock doesn't have jitter, it's derivates
are all constant/zero, and so jent_measure_jitter() - called via
jent_entropy_collector_alloc() - will always detect a stuck measurement,
and thus jent_gen_entropy() loops infinitely.

I wonder what you'd think about a patch like this?

--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -552,10 +552,13 @@ static int jent_measure_jitter(struct rand_data *ec, __u64 *ret_current_delta)
  * Function fills rand_data->hash_state
  *
  * @ec [in] Reference to entropy collector
+ *
+ * Return: 0 if entropy reading failed (was stuck), 1 otherwise
  */
-static void jent_gen_entropy(struct rand_data *ec)
+static int jent_gen_entropy(struct rand_data *ec)
 {
 	unsigned int k = 0, safety_factor = 0;
+	unsigned int stuck_counter = 0;
 
 	if (fips_enabled)
 		safety_factor = JENT_ENTROPY_SAFETY_FACTOR;
@@ -565,8 +568,13 @@ static void jent_gen_entropy(struct rand_data *ec)
 
 	while (!jent_health_failure(ec)) {
 		/* If a stuck measurement is received, repeat measurement */
-		if (jent_measure_jitter(ec, NULL))
+		if (jent_measure_jitter(ec, NULL)) {
+			if (stuck_counter++ > 100)
+				return 0;
 			continue;
+		}
+
+		stuck_counter = 0;
 
 		/*
 		 * We multiply the loop value with ->osr to obtain the
@@ -575,6 +583,8 @@ static void jent_gen_entropy(struct rand_data *ec)
 		if (++k >= ((DATA_SIZE_BITS + safety_factor) * ec->osr))
 			break;
 	}
+
+	return 1;
 }
 
 /*
@@ -611,7 +621,8 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 	while (len > 0) {
 		unsigned int tocopy, health_test_result;
 
-		jent_gen_entropy(ec);
+		if (!jent_gen_entropy(ec))
+			return -3;
 
 		health_test_result = jent_health_failure(ec);
 		if (health_test_result > JENT_PERMANENT_FAILURE_SHIFT) {


johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
