Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBDvt-0005im-KP
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 08:06:27 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1iBDvn-0004Jq-92
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 08:06:19 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1iBDvk-0002Zo-Ub
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 09:06:18 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Anyone running uml on a 5.x host?
Message-ID: <c5e112ff-3d53-784d-9f3d-38d36e27354a@kot-begemot.co.uk>
Date: Fri, 20 Sep 2019 09:06:16 +0100
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

Has anyone tried to run UML on a 5.2 host?

I get the following on 5.2 from debian testing:

Adding 93823388884992 bytes to physical memory to account for 
exec-shield gap
Too few physical memory! Needed=93823417974784, given=547037904896

The same machine when booted with 4.19 (stock) runs the same UML 
instance just fine.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

