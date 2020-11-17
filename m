Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kezpt-0002um-De
 for linux-um@lists.infradead.org; Tue, 17 Nov 2020 12:11:50 +0000
Message-ID: <cc3181a27ff19403db94385b42ec4a1feb60a965.camel@sipsolutions.net>
Subject: Re: [PATCH] um: borrow bitops from the x86 tree
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Nov 2020 13:11:29 +0100
In-Reply-To: <d2817ac8-e4a9-5d88-468e-03705e986b6e@cambridgegreys.com>
References: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
 <a5ad1be201a7488bdc317bc72776f1465347504f.camel@sipsolutions.net>
 <d2817ac8-e4a9-5d88-468e-03705e986b6e@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at

On Tue, 2020-11-17 at 11:46 +0000, Anton Ivanov wrote:
> 
> My usual test is:
> 
>   time busybox find /usr/lib/ -type f -exec cat {} > /dev/null \;
> 
> I discard the first run and use only runs from fs cache.

Oh. I didn't even run the timing inside. I ran it *outside*, something
like

time ./linux args... init=/path/to/test-script.sh

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

