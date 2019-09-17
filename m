Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADaS-0003KT-A0
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:32:10 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iADaP-0005IO-6R
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 15:32:05 +0200
Message-ID: <640e7817c839f6cf2e3ce53bae8a5bb686044a31.camel@sipsolutions.net>
Subject: Re: [RFC v3 1/2] um: virtio: implement
 VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 15:32:02 +0200
In-Reply-To: <1568726354-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
References: <20190917132943.20102-1-johannes@sipsolutions.net>
 <1568726354-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
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

On Tue, 2019-09-17 at 15:29 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We'll prefer this feature, under the assumption that only a
> few (simulation) devices will ever support it, since it's not
> very efficient.

This is mostly RFC because the spec changes to vhost-user haven't really
been accepted. I reposted them earlier and hopefully addressed all the
concerns there, but who knows ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

