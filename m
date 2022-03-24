Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXN4X-00GfU8-Iq
 for linux-um@lists.infradead.org; Thu, 24 Mar 2022 13:00:14 +0000
Message-ID: <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
Subject: Re: [RFC v1 01/10] roadtest: import libvhost-user from QEMU
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 24 Mar 2022 14:00:10 +0100
In-Reply-To: <20220311162445.346685-2-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-2-vincent.whitchurch@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org
Cc: kernel@axis.com, devicetree@vger.kernel.org, linux-um@lists.infradead.org, shuah@kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org

On Fri, 2022-03-11 at 17:24 +0100, Vincent Whitchurch wrote:
> Import the libvhost-user from QEMU for use in the implementation of the
> virtio devices in the roadtest backend.
> 

So hm, I wonder if this is the sensible thing to do?

Not that I mind importing qemu code, but:

 1) the implementation is rather complex in some places, and has support
    for a LOT of virtio/vhost-user features that are really not needed
    in these cases, for performance etc. It's also close to 4k LOC.

 2) the implementation doesn't support time-travel mode which might come
    in handy

We have another implementation that might be simpler:
https://github.com/linux-test-project/usfstl/blob/main/src/vhost.c

but it probably has dependencies on other things in this library, but
vhost.c itself is only ~1k LOC. (But I need to update it, I'm sure we
have some unpublished bugfixes etc. in this code)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

