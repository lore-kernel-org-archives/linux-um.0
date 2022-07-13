Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWpT-001GFM-CF
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 07:30:41 +0000
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1oBWRG-0001yL-47
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 07:05:42 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1oBWR8-003MuX-4H
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 08:05:35 +0100
Message-ID: <d75a84b6-55d4-7c08-14c0-948e0a8e9e19@kot-begemot.co.uk>
Date: Wed, 13 Jul 2022 08:05:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] um: seed rng using host OS rng
Content-Language: en-US
References: <20220712232738.77737-1-Jason@zx2c4.com>
 <d20a629c-8c15-ca8a-c34a-c5c084dbee03@cambridgegreys.com>
 <9a028efb77ae662fe8eabcf2ffb5a64214f07418.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <9a028efb77ae662fe8eabcf2ffb5a64214f07418.camel@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

On 13/07/2022 08:03, Johannes Berg wrote:
> On Wed, 2022-07-13 at 07:58 +0100, Anton Ivanov wrote:
>> IIRC UML RNG device reads directly from host.
> Yes, but that's a /dev/hwrng device, so you still need some userspace to
> feed entropy from that into /dev/random.
>
>> If you are using UMLs own /dev/random you are effectively using the host
>> one.
>> So unless I am mistaken, you need extra randomness only if you do not
>> have UMLs /dev/random compiled in.
> No, neither of those is true.

OK, Cool.

>
> johannes
>
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

