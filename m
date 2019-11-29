Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iahLS-0006tx-Tk
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 14:34:08 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1iahLQ-0002MS-2B
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 14:34:04 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1iahLN-0000Mc-S8
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 14:34:03 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: 64 bit time regression in recvmmsg()
Message-ID: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
Date: Fri, 29 Nov 2019 14:34:01 +0000
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
To: linux-um <linux-um@lists.infradead.org>

Hi all,

Unfortunately, it looks like the recent year 2038 have broken 
compatibility for one particular syscall interface we use - recvmmsg.

The host now occasionally returns -22 (EINVAL) and the only way I see 
for this to happen looking at the source is if when it gets something 
bogus as a timeout.

I think I have eliminated all other possible sources for this error.

The picture can be observed when using a 64 bit host 5.2 kernel on a 
Debian 64 bit buster userspace (glibc compiled vs 4.19 headers).

The code as it is written at present retries and by sheer luck and 
perseverance it manages to work, but this needs to be fixed.

Brgds,
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

