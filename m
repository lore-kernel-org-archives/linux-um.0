Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMwfH-0007qw-QW
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:01:17 +0000
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1gMwf5-0003GP-F2
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:00:59 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1gMwez-0006xK-UK
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:00:59 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: RFC - potential optimizations in uaccess.c
Message-ID: <af586267-1685-5cd0-1437-c2e56e2ebe2c@cambridgegreys.com>
Date: Wed, 14 Nov 2018 15:00:53 +0000
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

Hi all,

I am looking at uaccess.c and wondering. Is there some reason not to try 
to map the whole address range in buffer_op first before falling back to 
per page ops?

This should speed up things significantly on more than one level. In 
addition to the copy op being done (potentially) at once, any tlb 
flushes will also be done once, not repeatedly.

The question is - is there some architectural reason not to do this?

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

