Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oD1sb-006RGd-MS
	for linux-um@lists.infradead.org; Sun, 17 Jul 2022 10:52:07 +0000
Message-ID: <3a03bc428ebc5741494a3e05ee98f55be2bdd3ec.camel@sipsolutions.net>
Subject: Re: [PATCH v4] um: seed rng using host OS rng
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 17 Jul 2022 12:51:58 +0200
In-Reply-To: <20220717105051.1539173-1-Jason@zx2c4.com>
References: <20220717084652.1525087-1-Jason@zx2c4.com>
	 <20220717105051.1539173-1-Jason@zx2c4.com>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sun, 2022-07-17 at 12:50 +0200, Jason A. Donenfeld wrote:
> UML generally does not provide access to special CPU instructions like
> RDRAND, and execution tends to be rather deterministic, with no real
> hardware interrupts, making good randomness really very hard, if not
> all together impossible. Not only is this a security eyebrow raiser, but
> it's also quite annoying when trying to do various pieces of UML-based
> automation that takes a long time to boot, if ever.
> 
> Fix this by trivially calling getrandom() in the host and using that
> seed as "bootloader randomness", which initializes the rng immediately
> at UML boot.
> 
> The old behavior can be restored the same way as on any other arch, by
> way of CONFIG_TRUST_BOOTLOADER_RANDOMNESS=n or
> random.trust_bootloader=0. So seen from that perspective, this just
> makes UML act like other archs, which is positive in its own right.
> 
> Additionally, wire up arch_get_random_{int,long}() in the same way, so
> that reseeds can also make use of the host RNG, controllable by
> CONFIG_TRUST_CPU_RANDOMNESS and random.trust_cpu, per usual.
> 
> Cc: stable@vger.kernel.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Johannes - I need to take this through random.git, because it relies on
> some other changes living there. Is that okay with you? -Jason

Sure, go ahead, thanks for doing this work!

> Changes v3->v4:
> - Don't include os.h, per Johannes' suggestion.

Thanks.

Acked-by: Johannes Berg <johannes@sipsolutions.net>


johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

