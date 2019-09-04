Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5UtN-00020c-IC
 for linux-um@lists.infradead.org; Wed, 04 Sep 2019 13:00:10 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i5UtI-0008V5-Ka
 for linux-um@lists.infradead.org; Wed, 04 Sep 2019 15:00:05 +0200
Message-ID: <e759728af3b0e8a1188cd8956bc4ee2d3b66a68c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] um: virtio: implement VHOST_USER_PROTOCOL_F_SLAVE_REQ
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 04 Sep 2019 15:00:02 +0200
In-Reply-To: <20190904071116.8204-1-johannes@sipsolutions.net>
References: <20190904071116.8204-1-johannes@sipsolutions.net>
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

On Wed, 2019-09-04 at 09:11 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Implement the communication channel for the device to notify
> us of some events, and notably implement the handling of the
> config updates needed for the combination of this feature
> and VHOST_USER_PROTOCOL_F_CONFIG.

This has some error path issues, I'll resend later.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

