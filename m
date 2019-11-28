Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaNZg-0006UD-9Y
 for linux-um@lists.infradead.org; Thu, 28 Nov 2019 17:27:29 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1iaNZd-0007VW-0R
 for linux-um@lists.infradead.org; Thu, 28 Nov 2019 17:27:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1iaNZa-0000nA-Re
 for linux-um@lists.infradead.org; Thu, 28 Nov 2019 17:27:24 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: I get 5.4 fail to start
Message-ID: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
Date: Thu, 28 Nov 2019 17:27:22 +0000
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

I get 5.4 fail to start. 5.4 gives:

Checking that ptrace can change system call numbers...check_ptrace : 
child exited with exitcode 6, while expecting 0; status 0x67f
Aborted

And stops right at the very start.

I do not recall anything there changing in the 5.2 - 5.4 timeframe so 
this is weird.

Ideas?

-- 

Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

