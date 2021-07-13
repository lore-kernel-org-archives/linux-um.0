Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from so254-9.mailgun.net ([198.61.254.9])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3PCa-00BKt7-MS
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 20:40:26 +0000
MIME-Version: 1.0
Date: Tue, 13 Jul 2021 14:40:22 -0600
From: subashab@codeaurora.org
Subject: Re: UML kernel panic on initialization
In-Reply-To: <17bc19ae635b61d50627fd1601b0ab12b5128999.camel@sipsolutions.net>
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <6442ec0e5e2cf55990b43ff178023fd6050e63fb.camel@sipsolutions.net>
 <8c377addaa42a7dd3bbe047e1f744a51103e6ff2.camel@sipsolutions.net>
 <17bc19ae635b61d50627fd1601b0ab12b5128999.camel@sipsolutions.net>
Message-ID: <067d008eef6bd19e6fee22f16db40628@codeaurora.org>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org

> [snip]
> 
> And as yet another experiment in this area, does it work again if you
> apply this patch?
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20210303155523.124277-11-benjamin@sipsolutions.net/
> 
> Not sure it applies as-is, but you can see the schema there.
> 
> johannes

If this patch is applied without any reverts the crash is seen.
If patch is applied with the 3 reverts applied, the initialization
is hanging.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

