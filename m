Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEfAW-0007pX-ME
 for linux-um@lists.infradead.org; Tue, 23 Feb 2021 21:24:33 +0000
Message-ID: <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] PCI support for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 23 Feb 2021 22:24:25 +0100
In-Reply-To: <20210223152707.408995-1-johannes@sipsolutions.net>
References: <20210223152707.408995-1-johannes@sipsolutions.net>
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
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> In order to simulate some devices and write tests completely
> independent of real PCI devices, we continued the development
> of time-travel and related bits, and are adding PCI support
> here now.
> 
> The way it works is that it communicates with the outside (of
> UML) with virtio, which we previously added using vhost-user,
> and then offers a PCI bus to the inside system, where normal
> PCI probing etc. happens, but all config space & IO accesses
> are forwarded over virtio.

I hadn't sent it out until now, but the userspace bits for all the time-
travel and PCI-over-vhost-user are here:

https://github.com/linux-test-project/usfstl/

If anyone has any suggestions on a good example PCI device that already
has a driver upstream I'd be interested - I looked for something simple
like LED or GPIO but no such thing I could find (that wasn't platform
dependent in some way). So far I've only implemented a virtual Intel
WiFi NIC, but that depends on a large body of code I can't publish. As
an example, it would be nice to write (and publish there) a simple PCI
device implementation. :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

