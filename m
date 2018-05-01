Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDVYV-0003Zo-C9
 for linux-um@lists.infradead.org; Tue, 01 May 2018 13:42:56 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Question about process.c
Message-ID: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
Date: Tue, 1 May 2018 14:01:54 +0100
MIME-Version: 1.0
Content-Language: en-US
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
Cc: Richard Weinberger <richard.weinberger@gmail.com>

Hi all, hi Richard,

I have a question - is it really necessary to pass a "force" flag to a 
tlb flush before doing a fork (in process.c)?

If the flush is not forced, the fork becomes significantly less 
expensive. I tried running a couple of crude tests and did not notice 
anything broken if the flush there is done without a "force" flag.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/	


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

