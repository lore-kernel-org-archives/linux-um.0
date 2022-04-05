Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbjdP-001E5e-2P
 for linux-um@lists.infradead.org; Tue, 05 Apr 2022 13:54:16 +0000
Date: Tue, 5 Apr 2022 15:54:12 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [RFC v1 01/10] roadtest: import libvhost-user from QEMU
Message-ID: <20220405135412.GB28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-2-vincent.whitchurch@axis.com>
 <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f405d8d09a83954aa3411eff8b71ee687c7ec33.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "brendanhiggins@google.com" <brendanhiggins@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thu, Mar 24, 2022 at 02:00:10PM +0100, Johannes Berg wrote:
> On Fri, 2022-03-11 at 17:24 +0100, Vincent Whitchurch wrote:
> > Import the libvhost-user from QEMU for use in the implementation of the
> > virtio devices in the roadtest backend.
> 
> So hm, I wonder if this is the sensible thing to do?
> 
> Not that I mind importing qemu code, but:
> 
>  1) the implementation is rather complex in some places, and has support
>     for a LOT of virtio/vhost-user features that are really not needed
>     in these cases, for performance etc. It's also close to 4k LOC.

Is this really a problem given that the code is imported as-is?  The
intention is not to have to make a lot of local modifications to it in
the kernel tree.  The code is stable and presumably well-tested
upstream, and upstream maintains it as a separate library (in the QEMU
source tree though) to encourage reuse.

>  2) the implementation doesn't support time-travel mode which might come
>     in handy

True, but I don't see the external time-travel controller stuff being
too useful for the kinds of tests this framework is targeting.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

