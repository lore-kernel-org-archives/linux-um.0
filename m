Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Pkd-0005Lu-3C
 for linux-um@lists.infradead.org; Wed, 04 Sep 2019 07:30:48 +0000
Message-ID: <d3c3f6a5703b3d45a89e5818ad46f7a16b165b56.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: irq: Fix LAST_IRQ usage
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 04 Sep 2019 09:30:44 +0200
In-Reply-To: <20190904071007.7837-1-johannes@sipsolutions.net>
References: <20190904071007.7837-1-johannes@sipsolutions.net>
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
Cc: Erel Geron <erelx.geron@intel.com>

On Wed, 2019-09-04 at 09:10 +0200, Johannes Berg wrote:
> From: Erel Geron <erelx.geron@intel.com>
> 
> LAST_IRQ was used incorrectly in init_IRQ.
> Fix this.

Oops, ignore this one - I accidentally sent it instead of the virtio
code.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

