Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9nLi-0005o5-Uh
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 09:31:12 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i9nLh-00068x-Mm
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 11:31:09 +0200
Message-ID: <68e54546852b921cdd02e9241d583e7e9045ba4d.camel@sipsolutions.net>
Subject: Re: [RFC] synchronised multi-machine time-travel APIs
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 16 Sep 2019 11:31:08 +0200
In-Reply-To: <a216fef2119146de27168d0cf91ffa2f2b970e77.camel@sipsolutions.net>
References: <a216fef2119146de27168d0cf91ffa2f2b970e77.camel@sipsolutions.net>
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

On Mon, 2019-09-16 at 11:27 +0200, Johannes Berg wrote:
> 
> 2) The virtio/vhost-user framework is really not suited for synchronous
>    calls, I have to jump quite some hoops to make this work, polling the
>    return virtqueue's notifications, etc., and keep a lot of buffers and
>    SG structures around etc.

Some more thought on that: virtqueues always pass buffers back and
forth, and the UML system needs to provide buffers even for the tiny
messages, since we cannot communicate otherwise. This is great for bulk
transfers in virtio, but for the tiny 16-byte messages we're passing
it's kind of inefficient.

As a result, I didn't want to have many of them submitted for "RX" at
the same time and used only one, but then if the simulation calendar has
to send multiple messages I actually ended up resorting to polling there
until buffers are available, again a bit ugly.

If we simply have a (blocking) socket between them, we can write() the
small messages there and read() them out on the other side, without
having to worry about buffer allocations etc.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

