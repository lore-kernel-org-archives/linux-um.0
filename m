Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWPL-0011xc-Ev
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 07:03:40 +0000
Message-ID: <9a028efb77ae662fe8eabcf2ffb5a64214f07418.camel@sipsolutions.net>
Subject: Re: [PATCH] um: seed rng using host OS rng
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 13 Jul 2022 09:03:31 +0200
In-Reply-To: <d20a629c-8c15-ca8a-c34a-c5c084dbee03@cambridgegreys.com>
References: <20220712232738.77737-1-Jason@zx2c4.com>
	 <d20a629c-8c15-ca8a-c34a-c5c084dbee03@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

On Wed, 2022-07-13 at 07:58 +0100, Anton Ivanov wrote:
> 
> IIRC UML RNG device reads directly from host.

Yes, but that's a /dev/hwrng device, so you still need some userspace to
feed entropy from that into /dev/random.

> If you are using UMLs own /dev/random you are effectively using the host 
> one.

> So unless I am mistaken, you need extra randomness only if you do not 
> have UMLs /dev/random compiled in.

No, neither of those is true.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

