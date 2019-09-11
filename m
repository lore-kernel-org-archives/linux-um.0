Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i82W2-0005xC-08
 for linux-um@lists.infradead.org; Wed, 11 Sep 2019 13:18:35 +0000
Message-ID: <2b6ac17c16113892e27e82df9802264ef934d4d8.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/5] um: virtio support
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 11 Sep 2019 15:18:31 +0200
In-Reply-To: <20190911125122.20772-1-johannes@sipsolutions.net>
References: <20190911125122.20772-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

On Wed, 2019-09-11 at 14:51 +0200, Johannes Berg wrote:
> Yet another respin, with a small fix in the virtio platform data
> freeing code.

I'm getting to the "tiny little fixes" territory, so would appreciate if
you could give it a spin again.

I think quite possibly much of the issues you saw were just from the
uninitialized variable we had in one of the early versions, and
regardless of that the error messages should be more verbose now.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

