Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADgC-0005St-A0
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:38:06 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iADgB-0005QD-0G
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 15:38:03 +0200
Message-ID: <b88710e3eb352ff7f3f1df3a812e51e367d020f8.camel@sipsolutions.net>
Subject: Re: [RFC v3 2/2] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 15:38:01 +0200
In-Reply-To: <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
References: <20190917132943.20102-1-johannes@sipsolutions.net>
 <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
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

Forgot to say though - overall I'm MUCH happier with this than with the
virtio-based device. It's about 30% faster (as I said before), and both
sides of the communication channel are significantly less complex.

In particular, also, we need much less changes to virtio_uml.c since we
can still rely on getting signals and -EINTR in poll() even while we
talk over the timing channel but get a virtio message.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

