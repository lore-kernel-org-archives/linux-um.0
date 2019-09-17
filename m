Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAKO7-0000Z9-OM
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 20:47:53 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iAKO4-0006v8-VU
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 22:47:49 +0200
Message-ID: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
Subject: CONFIG_COMPAT for UM?
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 22:47:48 +0200
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Hi,

It seems to me that it ought to be possible - at least if the host
kernel has 32/64 compatibility, to extend the same to the UML kernel?

Has anyone ever given this a thought?

I just realized that our test suite is based on 32-bit binaries ... :-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

