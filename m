Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNKTh-0004kF-AB
 for linux-um@lists.infradead.org; Thu, 15 Nov 2018 16:26:50 +0000
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1gNKTR-0006YD-54
 for linux-um@lists.infradead.org; Thu, 15 Nov 2018 16:26:33 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1gNKTO-0008Nn-NB
 for linux-um@lists.infradead.org; Thu, 15 Nov 2018 16:26:32 +0000
Subject: Re: RFC - potential optimizations in uaccess.c
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <af586267-1685-5cd0-1437-c2e56e2ebe2c@cambridgegreys.com>
Message-ID: <2b3c6856-4ad9-b556-461b-1289c0d26e14@cambridgegreys.com>
Date: Thu, 15 Nov 2018 16:26:30 +0000
MIME-Version: 1.0
In-Reply-To: <af586267-1685-5cd0-1437-c2e56e2ebe2c@cambridgegreys.com>
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


On 11/14/18 3:00 PM, Anton Ivanov wrote:
> Hi all,
>
> I am looking at uaccess.c and wondering. Is there some reason not to 
> try to map the whole address range in buffer_op first before falling 
> back to per page ops?
>
> This should speed up things significantly on more than one level. In 
> addition to the copy op being done (potentially) at once, any tlb 
> flushes will also be done once, not repeatedly.
>
> The question is - is there some architectural reason not to do this?


I just re-read it and I realized why it all looks iffy.

This is all written for high memory. Unless I am mistaken, there should 
be no need for most of it for 64 bit architecture. It is presently 
incurring some very significant costs across the board which unless I am 
missing something simply should not be there.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

